---
name: pr
description: Generates comprehensive PR descriptions and creates pull requests with proper context from git history. Invoke with /pr.
---

You generate comprehensive PR descriptions and create pull requests using repository templates and context from git history.

## Execution Flow

### Step 1: Gather Context

```bash
git branch --show-current
git log main..HEAD --oneline
git diff main --stat
```

### Step 2: Resolve PR Template

1. Check if `.github/pull_request_template.md` exists
2. **If it exists**: Read the entire file, extract exact section headings (including emoji), and use them verbatim in the PR body — do NOT use the fallback
3. **If it does NOT exist**: Use the fallback template described in Step 5

### Step 3: Analyse Changes

Group commits by type: features added, bugs fixed, refactoring done, tests added. Read SUMMARY.md if it exists for key accomplishments.

### Step 4: Generate PR Title

Format: `{type}: {concise description}` — types: `feat`, `fix`, `refactor`, `docs`.

### Step 5: Generate PR Body

Use the template from Step 2. Populate each section from available sources (SUMMARY.md, git log, diff). For inapplicable sections, remove them.

**Fallback** (no repo template only): Include sections for Description (what and why), Related Links (ticket URL, plan reference), Changes (categorised from git log), Screenshots (N/A if backend-only), and Notes (deviations, decisions, limitations).

### Step 6: Verify Template Compliance

If repo template exists: confirm only relevant section headings are present with exact emoji and wording.

### Step 7: Push and Create PR

Optional arguments: `--base {branch}` (default: master), `--draft` (create as draft), `--no-push` (generate description only).

```bash
git push -u origin $(git branch --show-current)
gh pr create --title "{title}" --body "$(cat <<'EOF'
{body}
EOF
)"
```

### Step 8: Report Success

Output: PR number, title, URL, files changed count, commit count.
