---
name: reviewing-test-value
description: Reviews existing test suites for declaration-echo assertions, implementation coupling, redundant coverage and unnecessarily expensive test layers. Use for test-value audits, test cleanup, or reviewing suspected agent-written test slop.
---

# Reviewing test value

Reduce test maintenance cost without losing meaningful regression protection.

## Shared policy

Before proceeding, read `../_shared/testing-rules.md`, relative to this skill directory. It is the canonical testing policy. If unavailable, report the missing policy rather than claiming to have applied it.

When distributing this skill, include the sibling `_shared/testing-rules.md` file and preserve the relative layout. No Solo, MCP or particular test framework is required.

## Modes and scope

- Default to review-only: inspect and recommend, without editing tests or production code.
- Apply cleanup only when requested, subject to repository approval requirements for deleting tests.
- Use the user's named files, diff or subsystem. For a whole-suite request, work subsystem by subsystem and report how much was reviewed. Do not imply a sampled review covered the entire suite.

## Workflow

1. Read repository instructions and the relevant test setup. Inspect implementation and callers as well as tests; do not judge test value by assertion syntax alone.
2. Identify suspicious cases using the shared policy: literal/source/declaration echoes, CSS-class checks, generic framework mechanics, migration assertions, internal mock choreography, broad snapshots and overlapping coverage. These are candidates for investigation, not automatic deletion rules.
3. For each candidate, identify the contract, plausible defect and evidence that the test can or cannot detect it. Check for a compatibility, architecture or integration contract before recommending removal. Mark unresolved cases uncertain and preserve them.
4. Classify actionable findings as rewrite, move to a lower layer, merge or remove. Name the exact assertion/case involved, why it is low-value, and the specific coverage that will remain or replace it. Prioritise confidence risks and demonstrated maintenance/runtime costs; do not invent runtime savings.
5. In review-only mode, return the findings and stop. No baseline execution is required just to provide a read-only review; distinguish inspected evidence from executed checks.
6. In authorised cleanup mode, establish relevant baseline results before edits. Rewrite or replace valuable coverage before removing weak coverage. Work in small batches without changing production behaviour. Verify replacement sensitivity to the named defect when practical, following the shared safeguards.
7. Run affected tests and appropriate broader checks, restore any mutations, and inspect the final diff. Attribute existing failures separately. A green suite after deletion is not proof that useful coverage survived.

## Report

Keep the report in the response unless a file was requested. Include:

- Scope actually reviewed and a concise findings table: location, classification, contract/defect, evidence, and remaining or replacement coverage.
- In cleanup mode, changes actually applied, commands and results, and any measured before/after runtime using comparable runs. Omit runtime claims if unmeasured.
- Uncertain findings, uncovered risks and verification blockers. Explicitly state whether tests were only reviewed or changed.

Do not impose deletion targets or test-count quotas. A review that finds no low-value tests is a valid outcome.
