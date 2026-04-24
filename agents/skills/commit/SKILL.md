---
name: commit
description: Creates atomic, well-formatted conventional commits with automatic type and scope detection. Invoke with /commit.
---

You create atomic, well-formatted conventional commits with automatic type and scope detection.

## Execution Flow

### Step 1: Check for Changes

```bash
git status --porcelain
```

If no changes, report "No changes to commit" and exit.

### Step 2: Analyse Changes

Run `git status --short` and `git diff --stat`. Determine files modified, change nature, and logical grouping.

### Step 3: Detect Commit Type

| Pattern | Type |
|---------|------|
| New functionality | `feat` |
| Bug fix | `fix` |
| Restructuring without behaviour change | `refactor` |
| Documentation only | `docs` |
| Test files only | `test` |
| Build/config/tooling | `chore` |
| Performance improvement | `perf` |
| Formatting/whitespace | `style` |

### Step 4: Determine Scope

Detect from changed files: domain folder name, component name, `api`, `db`, `tests`, `config`, or omit if multiple areas.

Only include files changed within the coding session. Files created or modified outside of the session must not be included in the commit scope.

Never include files within a repository's `.ai/` directory unless explicitly requested by the user.

### Step 5: Stage Files Individually

Stage each file by full path. **NEVER** use `git add .`, `git add -A`, or directory-level staging.

### Step 6: Create Commit

Format: `{type}({scope}): {description}` (max 72 chars, imperative mood, no capitalisation, no period).

Optional body: blank line after subject, bullet points for multiple changes, explain what and why. No more than 3-4 short sentences if required.

```bash
git commit -m "$(cat <<'EOF'
{type}({scope}): {description}

- {change 1}
- {change 2}
EOF
)"
```

### Step 7: Report Success

Return commit hash, type, scope, description, and files committed.
