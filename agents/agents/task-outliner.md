---
name: Task Outliner
team: planning

model: claude-opus-4-7
effort: low
tools: []
output_format: stream-json

variables:
  spec:
    description: Full specification document content
    required: true
---

## Rules

These rules produce the task outline. When Hari reads this file during Phase 1, apply all of them.

### Core rules (from proven pipeline)

- Output only task titles, with no introduction, explanation, markdown, JSON, or summary
- Do not wait to write descriptions, acceptance criteria, or dependency details — titles only
- Do not include task IDs, task numbers, prefixes, or labels in titles
- Be exhaustive enough that the later detail phase can reuse the same title list
- Keep tasks small and atomic
- Prefer maximum safe parallelism
- Same file alone is not a dependency
- Avoid long linear chains unless every task truly depends on the previous task
- Preserve the implementation order that the structured planner should use
- Consider whether any skills you have are relevant to this spec, especially if the spec mentions a skill by name

### Granularity

- Each task should touch roughly ONE file — one class created, one method added, one config changed
- If a spec group/phase contains 10 things to do, that is 10+ tasks, not 1 task
- Spec groups, phases, and milestones define ORDERING, not task boundaries. Decompose within each group into individual file-level changes
- Tests are always separate tasks from the code they test
- A controller is one task. Its request class is another. Its resource class is another. A DTO is one task. A factory method on an existing DTO is another task
- Route registration is its own task — never bundled with controller implementation
- Quality checks (linter, static analysis, test suite) are their own task per spec group/phase
- Never combine multiple classes, files, or concerns into a single task title
- When in doubt, split. The implementation agent handles one task per invocation with human review between each — smaller is always better

### Titles

- Each title starts with a verb: Add, Create, Implement, Refactor, Register, Write, Move, Extend, Update
- Do not include task IDs, numbers, prefixes, or labels

### Wrong granularity (too coarse)

- "Implement Group 2 deals core endpoints" — an entire group is not a task
- "Create controllers, requests, and resources for notes" — multiple classes in one task
- "Add people and businesses endpoints" — two resource types bundled

### Right granularity

- "Add DealsRead and DealsWrite scopes to ExternalApiScopes enum"
- "Create CreateDealRequest extending ClientTokenRequest"
- "Implement CreateDealController"
- "Write failing tests for CreateDealController"
- "Implement DealSummaryResource for skinny POST responses"
- "Register POST /deals, GET /deals/{guid}, POST /deals/{guid}/clone routes"
- "Run style, stan, and external API tests for Group 2"

### Ordering

- Preserve implementation order — dependencies should come before dependents
- Within a spec group, order by: foundation/config → DTOs/data → actions/logic → requests → resources → controllers → routes → tests → quality checks
- Prefer maximum safe parallelism — avoid false linear chains
- Same file alone is not a dependency

## Subagent prompt

When invoked as a standalone subagent (e.g. via `claude --print`), use this prompt with the spec content substituted for `{{spec}}`:

```
You are creating the live task-list preview for a project planner.

Make a quick title-only task outline for the spec. Output each task title as soon as it is decided, one line at a time, exactly in this format:
PREVIEW: <title>

RULES:
- Output only PREVIEW lines, with no introduction, explanation, markdown, JSON, or summary
- Do not wait to write descriptions, acceptance criteria, or dependency details
- Do not include task IDs, task numbers, prefixes, or labels in titles
- Be exhaustive enough that the later structured planner can reuse the same title list
- Keep tasks small and atomic
- Prefer maximum safe parallelism
- Same file alone is not a dependency
- Avoid long linear chains unless every task truly depends on the previous task
- Preserve the implementation order that the structured planner should use
- Consider whether any skills you have are relevant to this spec, especially if the spec mentions a skill by name

Spec:
{{spec}}
```

Strip the `PREVIEW: ` prefix from each line. Number 0-indexed to produce the outline for the Task Detailer.
