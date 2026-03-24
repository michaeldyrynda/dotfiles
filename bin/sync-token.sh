#!/bin/bash
# Sync Claude Code OAuth token to OpenCode
# Works on macOS (Keychain) and Linux (~/.claude/.credentials.json)

set -e

CRED_FILE="$HOME/.claude/.credentials.json"
TOKEN_JSON=""
TOKEN_SOURCE=""

read_token_from_file() {
  if [ -f "$CRED_FILE" ]; then
    TOKEN_JSON=$(cat "$CRED_FILE")
    TOKEN_SOURCE="$CRED_FILE"
  fi
}

read_token_from_macos_keychain() {
  for service in \
    "Claude Code-credentials" \
    "Claude Code credentials" \
    "Claude Code" \
    "claude-code-credentials"
  do
    TOKEN_JSON=$(security find-generic-password -s "$service" -w 2>/dev/null || true)
    if [ -n "$TOKEN_JSON" ]; then
      TOKEN_SOURCE="macOS Keychain ($service)"
      return
    fi
  done

  read_token_from_file
}

# Detect OS and read credentials accordingly
case "$(uname -s)" in
  Darwin)
    read_token_from_macos_keychain
    ;;
  Linux|MINGW*|MSYS*|CYGWIN*)
    read_token_from_file
    ;;
  *)
    echo "Error: Unsupported OS ($(uname -s)). Only macOS, Linux and Windows (Git Bash) are supported."
    exit 1
    ;;
esac

if [ -z "$TOKEN_JSON" ]; then
  if [ "$(uname -s)" = "Darwin" ]; then
    echo "Error: No Claude Code credentials found in macOS Keychain or $CRED_FILE."
  else
    echo "Error: $CRED_FILE not found."
  fi
  echo "Make sure Claude Code is installed and you are logged in (run: claude auth status)"
  exit 1
fi

# Extract OAuth tokens
PARSED=$(printf '%s' "$TOKEN_JSON" | python3 -c "import json,sys
raw = sys.stdin.read().strip()
if not raw:
    raise SystemExit(1)
data = json.loads(raw)
oauth = data.get('claudeAiOauth') or data.get('oauth') or data
access = oauth.get('accessToken') or oauth.get('access')
refresh = oauth.get('refreshToken') or oauth.get('refresh')
expires = oauth.get('expiresAt') or oauth.get('expires')
if access is None or refresh is None:
    raise SystemExit(1)
if expires is None:
    expires = 0
print(f'{access}\t{refresh}\t{int(expires)}')")

IFS=$'\t' read -r ACCESS REFRESH EXPIRES << EOF
$PARSED
EOF

if [ -z "$ACCESS" ] || [ -z "$REFRESH" ]; then
  echo "Error: Could not extract tokens from credentials."
  exit 1
fi

# Write to OpenCode auth.json
case "$(uname -s)" in
  MINGW*|MSYS*|CYGWIN*)
    AUTH_DIR="${XDG_DATA_HOME:-$LOCALAPPDATA}/opencode"
    ;;
  *)
    AUTH_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/opencode"
    ;;
esac
AUTH_FILE="$AUTH_DIR/auth.json"
mkdir -p "$AUTH_DIR"

# Merge with existing auth.json to preserve other providers
if [ -f "$AUTH_FILE" ]; then
  python3 -c "
import json
try:
    with open('$AUTH_FILE') as f:
        auth = json.load(f)
except:
    auth = {}
auth['anthropic'] = {
    'type': 'oauth',
    'access': '$ACCESS',
    'refresh': '$REFRESH',
    'expires': $EXPIRES
}
with open('$AUTH_FILE', 'w') as f:
    json.dump(auth, f, indent=2)
"
else
  cat > "$AUTH_FILE" << EOF
{
  "anthropic": {
    "type": "oauth",
    "access": "$ACCESS",
    "refresh": "$REFRESH",
    "expires": $EXPIRES
  }
}
EOF
fi

if [ -n "$TOKEN_SOURCE" ]; then
  echo "Source: $TOKEN_SOURCE"
fi
echo "Done! Anthropic token synced to OpenCode."
echo "Expires: $(date -r $((EXPIRES / 1000)) 2>/dev/null || date -d @$((EXPIRES / 1000)) 2>/dev/null || echo "timestamp $EXPIRES")"
