---
name: migrate-plans
description: Migrates a project's .ai/ directory from the legacy flat layout to the slug-based plan directory structure. Invoke with /migrate-plans.
---

You migrate an existing `.ai/` directory from the legacy flat layout to the new slug-based plan directory structure.

## Legacy layout (before)

```
.ai/
├── plan.md          (or plans/*.md)
├── learnings.md
└── tasks/
    ├── 001.md
    └── ...
```

## New layout (after)

```
.ai/
└── plans/
    └── {slug}/
        ├── spec.md
        ├── learnings.md
        └── tasks/
            ├── 001.md
            └── ...
```

## Steps

1. **Discover plan files.** Check for:
   - `.ai/plans/*.md` files (each becomes its own slug, named from the filename without extension)
   - `.ai/plan.md` or any `.ai/*.md` (excluding `learnings.md`) as fallback candidates
   - If no plan files exist, stop and inform the user.

2. **Choose a slug.** For each plan file:
   - Derive the slug from the filename (e.g., `refactor-auth.md` → `refactor-auth`, `plan.md` → ask the user for a slug name since "plan" is too generic).
   - Confirm the slug with the user before proceeding.

3. **Create the new directory structure.** For each plan:
   - Run `mkdir -p .ai/plans/{slug}/tasks`
   - Move the plan file to `.ai/plans/{slug}/spec.md`
   - If `.ai/learnings.md` exists, move it to `.ai/plans/{slug}/learnings.md`
   - If `.ai/tasks/` exists and has `.md` files, move them all to `.ai/plans/{slug}/tasks/`

4. **Clean up.** Remove empty directories:
   - Remove `.ai/tasks/` if now empty
   - Remove `.ai/plans/*.md` files that were moved (but not the `plans/` directory itself)

5. **Report.** Show the user what was moved and the final directory tree.

## Rules

- Always confirm the slug name with the user before moving anything.
- If there are multiple legacy plan files AND a shared `tasks/` directory, ask the user which plan the tasks belong to.
- Never delete files — only move them. If something goes wrong, the originals should be recoverable.
- If `.ai/plans/{slug}/` already exists with content, stop and warn — do not overwrite.
