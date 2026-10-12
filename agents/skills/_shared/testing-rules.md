---
globs:
  - '**/tests/**'
  - '**/test/**'
  - '**/__tests__/**'
  - '**/*.test.*'
  - '**/*.spec.*'
  - '**/*Test.php'
  - '**/*Test.java'
  - '**/*Tests.cs'
  - '**/test_*.py'
  - '**/*_test.py'
  - '**/*_test.go'
---

# Testing rules

These rules are the shared policy for planning, writing and reviewing tests. Read them before writing test acceptance criteria or test code, and when assessing existing coverage. Repository instructions and explicit application contracts take precedence; report conflicts rather than silently overriding them.

## Require a meaningful application contract

Before adding or retaining a test, identify:

1. The observable application contract it protects, grounded in requirements, callers or established behaviour.
2. A plausible defect that would violate that contract and make the test fail.
3. An input and independently derived expected result that distinguish correct behaviour from that defect.

If these cannot be identified, do not add the test. During review, investigate before recommending removal; an unclear contract is not proof that no contract exists.

Test validation, calculations, conditional decisions, state transitions, authorisation, error handling, persistence, externally meaningful side effects and integration between application components. Assert correct outcomes, not just that nothing crashed.

## Do not echo declarations or test dependencies

Do not add tests that merely:
- Compare a literal with itself, or use the production function under test to calculate its own expected result.
- Instantiate a plain DTO/value object and check that its properties contain the constructor arguments.
- Repeat an enum's declared case names, count, backing values or trivial label mappings.
- Assert that a route exists after registration, a config value returns what the test just set, or a generic framework helper works.
- Require or execute application migration files to assert their schema declarations, or check that a migration calls particular schema methods.
- Assert generic model fillable/cast/relationship mechanics without exercising an application-specific contract.
- Read source files and assert that implementation snippets occur in them.

These are review signals, not automatic deletion rules. A declaration can encode a real compatibility or architectural contract. For example:
- Keep a test that verifies an independently specified external API status such as `"pending"`; do not keep a test that only restates `Status::Pending->value`.
- Exercise configured relationships through application behaviour, including tenant filtering, ordering or persistence where these matter.
- Exercise routes through their request/response, middleware and authorisation behaviour, not route registration alone.
- Keep explicit architecture constraints when they protect a justified project-wide boundary, rather than the incidental shape of one implementation.

Ordinary application tests may use the normal migrated test database. Test application persistence and meaningful constraints, not migration source. Migration tools or explicitly required upgrade/data-backfill compatibility need a separate verification strategy, subject to repository policy; do not invent one for every schema change.

## Assert behaviour, not implementation details

- A behaviour-preserving refactor should not break a behaviour test. Do not pin private helper names, internal call order, DOM nesting or incidental formatting.
- Do not assert CSS/Tailwind class strings to prove a user interaction works. Check visibility, enabled/disabled state, accessibility state, focus or the interaction's outcome as appropriate.
- For a deliberate appearance contract, use suitable rendered visual verification. Class equality does not prove appearance.
- Assert exact copy, ordering, serialised values or markup only when their exact form is part of the contract. Exact string comparisons are not inherently low-value.
- Prefer observable outcomes over internal mock interactions. An outbound request or notification can itself be the contract; assert its meaningful destination/payload without replacing the application behaviour being tested.
- Avoid broad snapshots that freeze unrelated output. Keep narrowly scoped snapshots only when their contents are a deliberate, reviewable contract.

## Use discriminating data and independent expectations

- Choose inputs on which the plausible wrong implementation and the correct implementation differ. Prefer asymmetric values and meaningful boundary cases over convenient symmetric fixtures.
- Cover important rejection paths as well as success, particularly permissions, tenant isolation, validation and state transitions. Assert absence of forbidden side effects where relevant.
- Derive expected results from the contract, not by copying the production algorithm or calling the same helper on both sides of an assertion.
- Use deterministic time, randomness and dependency isolation where needed. Do not add arbitrary sleeps, blanket retries or weaker assertions to hide flakes.
- Confirm that a failing test exposes the relevant missing or wrong behaviour, rather than a syntax error, broken fixture or unrelated environment failure. When adding coverage for existing correct behaviour, check sensitivity to the named defect when practical; do not change production behaviour just to manufacture a red result.

## Choose the lowest sufficient test layer

- Use unit tests for isolated logic with meaningful decisions or transformations.
- Use feature/integration tests for application boundaries, persistence, authorisation and collaboration between components.
- Use browser/end-to-end tests when the risk requires a real browser or a complete connected journey, such as JavaScript behaviour, focus, navigation or client/server wiring.
- Do not move every assertion into a browser merely to favour end-to-end testing. Preserve a small set of critical connected journeys and cover detailed cases at cheaper reliable layers.
- Extend existing cases before adding parallel coverage. Consolidate tests that catch the same defect, but preserve distinct integration risks across layers.
- Optimise for confidence and reliable feedback, not test counts or coverage percentages. Do not impose arbitrary test quotas.

## Review and cleanup safeguards

- Read the implementation and relevant callers before classifying a test. A suspicious assertion alone does not justify deleting the whole test.
- Default to review-only unless cleanup is requested. Honour repository approval requirements for removing tests, even in cleanup mode.
- Classify findings as keep, rewrite, move to a lower layer, merge, remove or uncertain. Name the contract, plausible defect, evidence and remaining coverage for each proposed change.
- Establish relevant baseline results before cleanup and distinguish existing failures from regressions. A green suite after deletion does not demonstrate preserved coverage.
- Keep production behaviour unchanged during cleanup. Do not introduce production refactors, dependencies or CI redesigns solely to make a test review easier.
- Where replacing coverage, verify that the replacement detects the named wrong behaviour through a meaningful failing case or a small reversible mutation when practical. Restore mutations before running final checks; do not mutate shared or production environments.
- Separate temporary diagnostic checks from permanent regression tests. Retain only checks that protect a real contract against a plausible future defect.
- Apply authorised changes in small batches, run affected tests and appropriate broader checks, and report actual results and any unverified coverage.

## Red-green-refactor — one test at a time

When implementing new or changed behaviour, use strict TDD discipline. One test, one code path, one red-green-refactor cycle. This implementation workflow does not require changing correct production code merely to make an existing test fail during review or cleanup.

- Write ONE failing test. See it fail. Write the minimum code to make it pass. Refactor. Move to the next test.
- Never write multiple tests before implementing production code.
- Never write all tests first then make them pass in bulk.
- Never skip the red step — every test must be observed failing before you write production code for it.
- Never write production code that satisfies a future test before that test exists.

For the **task-planner**: each test acceptance criteria bullet must map to a single behaviour or code path. One bullet = one test = one red-green-refactor cycle. If a bullet would require testing two distinct code paths, split it into two bullets.

For the **task-implementor**: if an acceptance criteria bullet asks for a test that merely echoes declarations or tests dependency mechanics, report why it provides no application confidence and skip it. If the bullet represents a real contract but proposes a weak assertion, test that contract through behaviour instead.
