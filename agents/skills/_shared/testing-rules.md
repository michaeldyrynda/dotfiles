# Testing rules

These rules apply to both writing test bullets (task-planner) and writing test code (task-implementor).

## Do not test the language or framework

Every test must exercise behaviour that YOUR code introduces. If removing your code wouldn't break the test, the test is worthless.

Do not:
- Instantiate a readonly DTO/value object and assert its properties hold the values passed to the constructor — this tests PHP, not your code
- Assert that an enum case has its declared string value (e.g., `LoanProduct::ConsumerAsset->value === 'Consumer Asset'`) — this tests the language
- Assert that a Laravel route exists after you registered it — the framework guarantees this
- Assert that a config value returns what you just set — this tests the framework's config system
- Assert that a model's fillable/cast/relationship declarations work as declared — Eloquent already guarantees this

Instead, test the behaviour your code adds: validation logic, computed values, conditional branching, state transitions, error handling, side effects, and integration between your components.

## Red-green-refactor — one test at a time

Strict TDD discipline. One test, one code path, one red-green-refactor cycle.

- Write ONE failing test. See it fail. Write the minimum code to make it pass. Refactor. Move to the next test.
- Never write multiple tests before implementing production code.
- Never write all tests first then make them pass in bulk.
- Never skip the red step — every test must be observed failing before you write production code for it.
- Never write production code that satisfies a future test before that test exists.

For the **task-planner**: each test acceptance criteria bullet must map to a single behaviour or code path. One bullet = one test = one red-green-refactor cycle. If a bullet would require testing two distinct code paths, split it into two bullets.

For the **task-implementor**: if an acceptance criteria bullet asks for a test that merely tests the language or framework (per the rules above), skip it and move to the next bullet.
