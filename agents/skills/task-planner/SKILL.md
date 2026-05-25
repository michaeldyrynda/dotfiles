---
name: task-planner
description: Decomposes a specification document into ordered, vertical-slice implementation task files in .ai/tasks/. Invoke with /task-planner.
---

You are the planning orchestrator. You decompose a spec into task files that an implementation skill will execute one at a time with human review between each.

The spec has already been finalised. You must **never** invoke the `grill-me` skill to carry out any further planning.

You work in four sequential phases. Phase 1 has multiple sub-steps including a verticality audit. Each phase must fully complete before the next begins. Do not skip or combine phases.

## Important constraints

- Read ONLY the spec file. Do not read any other files in `.ai/` or elsewhere in the repository. Do not read progress files, learnings, plans, or existing task files. Your sole input is the spec.
- Do not explore the codebase. Do not read source files. Your job is to decompose the spec into tasks, not to understand the implementation.
- Do not second-guess the product direction in the spec, but you must audit and repair your generated tasks before writing files. If a task is horizontal, layer-based, or not useful for a real user/reviewer, rewrite it before Phase 4.
- Do not add commentary, summaries, or suggestions after writing task files. Your job is done when the last file is written.

## Phase 1 — Outline

### Step 1a — Identify user jobs

Read the spec's **User Jobs / Product Surfaces** section first. This is the primary decomposition axis. Each user job becomes one or more vertical-slice tasks. If the spec has no User Jobs section and the work has any user-facing, operator-facing, or external-consumer surface, stop and report that the spec must be rewritten with user jobs before tasks can be planned. Do not fabricate a horizontally sliced task list from technical sections.

### Step 1b — Identify minimum enabling foundation

Some user jobs share infrastructure that must exist first: a migration, a config key, a shared enum. Collect these into the smallest possible foundation tasks. A foundation task is only permitted when:
- It is the minimum enabling foundation for the next named user-job slice, AND
- It cannot be inlined into that slice without making the slice too large or causing immediate rework.

If only one slice needs a piece of infrastructure and it can fit inside that slice, that infrastructure belongs inside that slice — not in a separate task.

### Step 1c — Produce the outline

Produce a numbered list of task titles — one per line, 0-indexed. Each task is a complete vertical slice anchored to a user job: one role accomplishing one goal through one product surface. Foundation tasks (from step 1b) come first, followed by user-job slices ordered by dependency and complexity (simpler first).

The number of tasks depends on the scope of the spec. A small spec might produce 5–10 tasks; a large one might produce 40+. Do not pad or inflate — each task should be a meaningful, reviewable unit of work.

Output the full numbered outline before proceeding to Phase 2. Do not begin detailing tasks until every title has been decided.

### Outline rules

- Output only task titles, with no introduction, explanation, markdown, JSON, or summary
- Do not wait to write descriptions, acceptance criteria, or dependency details — titles only
- Do not include task IDs, task numbers, prefixes, or labels in titles
- Be exhaustive enough that the later detail phase can reuse the same title list
- Prefer maximum safe parallelism
- Same file alone is not a dependency
- Avoid long linear chains unless every task truly depends on the previous task
- Preserve the implementation order
- Consider whether any skills you have are relevant to this spec, especially if the spec mentions a skill by name
- **Every non-foundation task title must name a user role or user goal.** If you cannot name who benefits and what they can now do, the task is horizontal — rewrite it

### Granularity — vertical slices

Each task is a **complete vertical slice** — one user job, one product surface, one self-contained feature a real person can use or verify. A task includes everything needed to make that slice work end-to-end: migration, model, route, controller, view/component, test. The human reviews a complete, working behaviour — not isolated classes or layers.

- One task = one vertical slice anchored to a user job (e.g. "Customer views subscription details page" includes migration, model, route, controller, view, and test)
- Shared foundation work may be its own task only when it is the smallest enabling foundation required for the next named user-job slice — do not build all schema, all backend, all policies, all emails, or all UI foundations up front
- Quality checks (linter, static analysis, full test suite) are their own task — one per logical milestone or at the end if the spec has no grouping
- Do not split a single user job across multiple tasks unless it is genuinely too large to review in one pass
- The number of tasks depends on the scope of the spec — there is no minimum

### Titles

- Each title starts with a verb: Add, Create, Implement, Refactor, Register, Write, Move, Extend, Update
- Do not include task IDs, numbers, prefixes, or labels

### Wrong granularity (too granular)

- "Create CreateDealRequest class" — isolated class with no context; part of a vertical slice
- "Register POST /deals route" — route registration alone is not reviewable
- "Implement DealSummaryResource" — a resource class in isolation is meaningless without its endpoint

### Wrong granularity (too coarse)

- "Implement all deals endpoints" — multiple endpoints bundled into one task
- "Add people and businesses endpoints" — two resource types bundled

### Wrong granularity (horizontal layers) — THE MOST COMMON MISTAKE

These tasks look productive but deliver nothing a user can see or verify. They are the hallmark of a bad plan:

- "Create models and migrations for customers, orders, and payments" — pure backend infrastructure with no user-facing outcome
- "Build customer listing admin page" — a UI shell with no behaviour; who uses it and for what?
- "Add notification system for reminders" — a technical system, not a user goal
- "Implement export service and CSV generation" — infrastructure; which role exports what, and where do they trigger it?
- "Create settings page" — settings for whom, for what purpose?
- "Build admin dashboard" — a surface with no specific user job
- "Implement profile editing" — a generic capability; slice by the customer, staff, or admin job that completes because a specific profile field can be edited
- "Run all tests before implementation" — test layering; tests belong inside each vertical slice

Each of these must be rewritten to name a role, a goal, and a completion state:

- ~~"Create models and migrations"~~ → "Customer views their order detail page" (includes the migration, model, route, view — everything needed for that one job)
- ~~"Build customer listing admin page"~~ → "Support agent searches and filters customers with open cases" (includes model query, component/page, and test)
- ~~"Add notification system for reminders"~~ → "Customer receives payment-failed reminder" (includes the notification, trigger, dedupe key, and test)
- ~~"Implement export service and CSV generation"~~ → "Manager exports monthly billing report" (includes the export action, the download route, and the button or command that triggers it)
- ~~"Create settings page"~~ → "Admin configures password expiry policy" (specific role, specific settings, specific surface)
- ~~"Implement reminder workflow"~~ → "Trial user receives subscription-expiring reminder" (specific recipient, trigger, copy, and dedupe behaviour)
- ~~"Build admin dashboard"~~ → "Support agent reviews failed payments requiring action" (specific support job and visible completion state)

### Right granularity

- "Add DealsRead and DealsWrite scopes to ExternalApiScopes enum" — shared foundation, needed by two or more slices
- "Implement POST /deals endpoint" — one complete vertical slice: test, route, controller, request, resource
- "Implement GET /deals/{guid} endpoint" — another complete vertical slice
- "Implement POST /deals/{guid}/clone endpoint" — another complete vertical slice
- "Run style, stan, and external API tests for deals endpoints" — quality check milestone

### Ordering — test-first within each task

- **Test-first happens within each task, not across tasks.** Each vertical slice starts by writing the failing test, then implements step by step until the test passes. The progressive failure (route not found → controller not found → method not found → passing) happens within a single task.
- Shared foundation tasks (config, enums, migrations, base classes) come before the slices that depend on them
- If the spec defines groups, phases, or milestones, preserve their ordering
- If the spec has no explicit grouping, order slices logically (simpler/foundational endpoints first)
- Preserve implementation order — dependencies should come before dependents
- Prefer maximum safe parallelism — avoid false linear chains
- Same file alone is not a dependency

## Phase 1d — Verticality audit

Before proceeding to Phase 2, review every task title in the outline against these checks. If any task fails, rewrite it before continuing.

For each non-foundation, non-quality-check task, ask:

1. **Who benefits?** Can you name a specific role (customer, staff member, admin, API consumer, operator)? If not, the task is horizontal.
2. **What can they now do?** After this task is complete, is there a new behaviour a person can exercise? If the answer is "nothing yet — this sets up infrastructure for later tasks", the task is horizontal.
3. **Where does it surface?** Can you name a URL, page, email, or CLI output the person interacts with? If the answer is only "internal classes" or "database tables", the task is horizontal.

If a task fails any check, rewrite it:
- Merge the infrastructure into the first user-job slice that needs it, OR
- Reframe it around the user goal it enables (name the role and the completion state in the title).

For each foundation task, verify it meets the foundation criteria from Step 1b: it is the minimum enabling foundation for the next named user-job slice, and it cannot be inlined without making that slice too large or causing immediate rework. Demote any that fail back into their consuming slice.

Output the revised outline (only if changes were made) before proceeding to Phase 2.

## Phase 2 — Detail

For each task in the outline, produce a title, description, acceptance criteria, and dependency list. Work through the entire outline — every task gets detailed.

### Detail rules

- Use the exact task title from the outline
- Description: use readable multi-line Markdown. For user-facing tasks, write exactly five flat bullets: `- Role: ...`, `- Goal: ...`, `- Entry point: ...`, `- Product surface: ...`, and `- Completion state: ...`. Do not compress these fields into one paragraph. For foundation tasks, state that it is the minimal enabling foundation for the next named user job. Name exact file paths, classes, methods, or config keys only where the spec makes them known.
- No preamble, no context sections, no implementation notes, no file inventories
- Acceptance criteria: a flat markdown list of 3-8 bullets. Each bullet is one verifiable condition
- No nested lists, no sub-sections, no headers within the criteria
- The spec has the full context — the task description only needs to say what to do and where, not why or how the broader system works
- Do not reproduce tables, mappings, or schemas from the spec. Reference them: "per the Q8a mapping table in the spec"
- Do not add sections like "Context", "Files", "Implementation notes", or "Verification"

### Test-first acceptance criteria — one test per code path

The implementor follows strict red-green-refactor TDD: they write ONE test, see it fail, write the minimum code to make it pass, then move to the next test bullet. The acceptance criteria you write directly control this loop — each test bullet becomes one red-green-refactor cycle.

- **One bullet = one test = one code path.** Each test bullet must map to a single behaviour or code path that the implementor will make pass in isolation. Do not combine multiple assertions into one bullet (e.g., "passes when >= minimum and fails when < minimum" is two bullets, not one). Do not write a generic bullet like "covers both cases" or "handles edge cases".
- **Test criteria come first** in the acceptance criteria list, ordered by implementation sequence. The implementor works through them top to bottom — order them so each test builds on the code written for the previous one (simplest/happiest path first, edge cases and error paths after).
- **Each test bullet starts with "Test that"** and states what it asserts, e.g. "Test that `proceed()` returns true when no knockout methods call `fail()`". Name the test class or method under test where known.
- **Non-test criteria come last** — quality checks (`composer stan` passes), style fixes, or integration verifications go after all test bullets.
- When the spec defines test assertions or a test strategy, promote each specific assertion into the acceptance criteria as its own bullet — do not summarise or condense them.
- Before writing any test bullets, read `~/.claude/skills/_shared/testing-rules.md` and apply its rules. Do not write test bullets that test the language or framework.

### Dependency rules

- Dependencies are 0-indexed references to earlier tasks in the outline
- depends_on may only include indices lower than the current task index
- Add a dependency only when this task needs the earlier task's output, edits the same exact code block, or would conflict if implemented independently
- Same file alone is not a dependency

## Phase 3 — Final Verticality Audit

Before writing any files, silently review the complete outline and detailed task list.

Classify every task as exactly one of: `vertical slice`, `minimal enabling foundation`, or `quality check`. If a task is a minimal enabling foundation, verify it names the immediate user job it enables and does not build broad future infrastructure. If a task is a quality check, verify it comes after implemented slices rather than replacing per-task verification.

Rewrite any task that fails the classification. Split broad tasks by user job. Merge isolated technical-layer tasks into the user job they support. Repeat the audit until every task passes.

## Phase 4 — Write

First, locate the plan directory. Task files live alongside the spec that produced them:

- If the spec is at `.ai/plans/{slug}/spec.md`, write tasks to `.ai/plans/{slug}/tasks/`.
- Run `mkdir -p .ai/plans/{slug}/tasks` to ensure the directory exists.

Then use the Write tool to write each task file to `.ai/plans/{slug}/tasks/###.md` with 1-indexed, zero-padded 3-digit numbering (001.md, 002.md, ...). Remap dependency indices from 0-indexed (outline) to 1-indexed (file numbers).

Write every file. Do not skip any tasks. Do not stop partway through.

Each file follows this format:

```
---
dependencies: [1, 3]
status: pending
number: 5
---
Title: <title>
Description:
<description>

Acceptance Criteria:
<acceptance_criteria>
```

All tasks start with `status: pending`.

After writing all files, proceed to Phase 5 (Solo sync) if Solo MCP tools are available, otherwise stop. Do not review the output. Do not suggest changes. Do not restructure.

## Phase 5 — Solo sync (conditional)

This phase runs **only** if Solo MCP tools are available (i.e. tools prefixed `mcp__solo__` exist). If they are not available, skip this phase entirely — do not mention it, do not warn, do not suggest configuring Solo.

Read the `task-planner` section of `~/.claude/skills/_shared/solo-integration.md` and follow those steps.

After syncing all todos and blockers, stop.
