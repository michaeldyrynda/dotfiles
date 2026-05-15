---
name: to-spec
description: Write the current conversation's planning context into a spec.md file with plan directory scaffolding and optional Solo sync. Invoke with /to-spec.
---

This skill takes the planning context from the current conversation and writes it out as a structured spec. Do NOT interview the user — synthesize what has already been discussed.

The user may provide a path or slug. If not, derive the slug from the conversation topic (e.g. `api-deals-role-tree`).

## Process

1. **Determine the plan slug.** If the user provided a path like `.ai/plans/{slug}/spec.md`, extract the slug. If they provided just a slug, use it. If neither, derive a short kebab-case slug from the conversation topic. Confirm the slug with the user only if it was derived — not if it was explicitly provided.

2. **Scaffold the plan directory.** Run:
   ```
   mkdir -p .ai/plans/{slug}/tasks
   touch .ai/plans/{slug}/learnings.md
   ```

3. **Write the spec.** Use the Write tool to create `.ai/plans/{slug}/spec.md`. The spec body is synthesized from the conversation. Use the template below as a guide, but adapt sections to fit the work discussed. Not every section applies to every spec.
**Always write the full spec content** to the scratchpad, not a summary or link to the file. The scratchpad should be a complete, self-contained copy of the spec.

4. **Solo sync (conditional).** If Solo MCP tools are available (i.e. tools prefixed `mcp__solo__` exist), read the `to-spec` section of `~/.claude/skills/_shared/solo-integration.md` and follow those steps. If Solo MCP tools are not available, skip silently — do not mention Solo or suggest configuring it.

5. **Report.** Output the path to the written spec and confirm the directory structure was created. If Solo sync happened, mention the scratchpad was updated.

## Spec template

Use this as a structural guide. Omit sections that don't apply. Add sections that the conversation warrants. The goal is a spec that the `/task-planner` skill can decompose into vertical-slice tasks.

```markdown
# {Title}

## Overview

2-3 sentences on what this work achieves and why.

## Payload Shape / API Contract / Interface

Concrete examples: JSON payloads, function signatures, CLI usage, schema definitions. Whatever makes the contract unambiguous.

### Field definitions

Table of fields with type, required/optional, and description.

## Domain Model / Enum / Config

New types, enums, config keys, or constants introduced by this work. Include the mapping to existing domain concepts where relevant.

## Validation Rules

Validation logic, constraints, after-validation hooks. Reference existing validators if extending them.

## Behaviour

Step-by-step description of what the implementation does at runtime. Name the action/service classes, their signatures, and the order of operations.

### Design constraints

Invariants, things deliberately excluded, entry-point agnosticism, idempotency guarantees.

Always include:
- **TDD is mandatory.** Red-green-refactor, strictly one test at a time. Never write all tests then implement.

## Testing

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Testing | Strict TDD red-green-refactor | One test at a time, green before next. Never write all tests then implement. |

Specify test file locations and the kinds of tests expected (unit, feature, integration). If particular assertions or scenarios are known, list them — the task planner will promote each into its own acceptance criteria bullet, and the implementor will use each as a single red-green-refactor cycle.

## Edge Cases

Bullet list of edge cases and how each is handled.

## Files to Create/Modify

### New files
- Path — one-line description

### Modified files
- Path — what changes
```

## Rules

- Do NOT interview the user. Synthesize from the conversation context.
- Do NOT explore the codebase to fill gaps. The spec captures what was planned, not what currently exists.
- Do NOT invoke `/task-planner` or `/grill-me`. This skill writes the spec and stops.
- If the conversation lacks enough context for a meaningful spec, say so and stop — do not fabricate.
- Use Australian English throughout (authorised, organisation, behaviour, etc.).
