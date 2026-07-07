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

If the branch targets a non-default base (e.g. a parent feature branch), diff against that base instead.

### Step 2: Resolve PR Template

1. Look for a PR template in the repository (common locations: `.github/pull_request_template.md`, `.github/PULL_REQUEST_TEMPLATE.md`, `docs/pull_request_template.md`)
2. **If a template exists**: Read the entire file, extract exact section headings (including emoji if present), and use them verbatim in the PR body — do NOT use the fallback
3. **If no template exists**: Use the fallback template described in Step 5

### Step 3: Analyse Changes

Read the full diff (production code, not tests) to understand what **behaviour** changed. Identify:

- New or changed rules, conditions, or decision logic
- Changed values or constants — note old vs new
- Removed or replaced behaviour
- Structural refactors that affect how the system behaves

Do NOT catalogue files, classes, or methods. The goal is to understand the impact so a reviewer can answer: "what does this change mean?"

### Step 4: Generate PR Title

Format: `{type}: {concise description}` — types: `feat`, `fix`, `refactor`, `docs`, `chore`.

### Step 5: Generate PR Body

Use the template from Step 2. Populate each section from available sources (SUMMARY.md, git log, diff).

#### Writing Style

- **Present tense throughout** — write "adds", "changes", "removes", not past ("added") or future ("will add"). The PR description describes what the code does now.
- **Describe the final state, not the journey** — the description represents HEAD, not the sequence of commits that got there. Don't mention intermediate refactors, reverts, or iterations. A reader should understand what the branch does, not how it was developed.
- **Describe behaviour, not code** — a reviewer needs to understand what *logic* changed, not which files were touched. Write about what the system does differently. Never list changed files, test files, or commit-by-commit narratives.
- **Use tables for before/after comparisons** — when values change (constants, limits, configuration), present them in a table with old and new columns. Tables are scannable and make the scope of change immediately clear.
- **Group by logical concept, not by file** — use subheadings that describe the change in domain terms, not implementation terms. Each group should describe one coherent behavioural change.
- **Call out new behaviour explicitly** — if something didn't exist before, mark it clearly (e.g. "—" in the old column of a table, or "new" in prose).
- **Minor refactors get a light touch** — if a refactor doesn't change behaviour (e.g. extracting a method, renaming for clarity, using an enum instead of a string), a single bullet under a "Minor refactors" subheading is sufficient. Don't over-explain mechanical changes.

#### Template Adherence

- **All template sections must be present** — never remove a section from the template, even if it doesn't apply.
- **Inapplicable sections get `N/A`** — write exactly `N/A` with no qualifier, explanation, or elaboration (not "N/A — backend only", not "No screenshots needed", just `N/A`).

**Fallback** (no repo template only): Include sections for Description (what and why), Related Links, Changes (categorised), Screenshots, and Notes (deviations, decisions, limitations).

### Step 6: Verify Template Compliance

Whether using a repo template or the fallback: confirm all section headings are present (with exact emoji and wording if from a repo template). Confirm inapplicable sections contain only `N/A`. Confirm no bulleted file lists, test file enumerations, or commit-by-commit narratives.

### Step 7: Push and Create PR

Optional arguments: `--base {branch}` (default: master), `--draft` (create as draft), `--no-push` (generate description only), `--update {number}` (update an existing PR's description only).

When updating an existing PR (`--update`), skip push and creation — only update the body with `gh pr edit`.

```bash
git push -u origin $(git branch --show-current)
gh pr create --title "{title}" --body "$(cat <<'EOF'
{body}
EOF
)"
```

### Step 8: Report Success

Output: PR number, title, URL, files changed count, commit count.
