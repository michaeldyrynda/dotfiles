---
name: review-pr-tests
description: Runs a combined test review of a branch or PR by running the test-review (coverage gaps) and review-test-value (low-value tests) skills on the same change, then reconciles their findings into one action per contract. Use when asked for a comprehensive, combined or full test review of a PR or branch. For only coverage gaps or only test value, use those skills directly.
---

# Reviewing PR tests

Produce one reconciled test review of a change, so the user never has to resolve conflicting findings by hand. Two reviewers look at the change with different lenses: `test-review` finds behaviour that lacks protection, and `review-test-value` finds tests that cost more than they protect. They conflict when both make a finding about the same behaviour, for example one says to strengthen a test the other says to remove. This skill reconciles those findings into one action per contract.

Read `../_shared/testing-rules.md`, relative to this skill directory, before reconciling. Its "Review findings" section defines the fields and actions used below, and its rules settle layer and coverage disagreements.

## 1. Fix the scope once

Both reviewers must review the same change, or their findings cannot be matched.

- Review the branch checked out locally. For a teammate's PR that is not checked out, run `gh pr checkout <number>` when the worktree is clean; otherwise ask the user.
- Find the base: the PR's base branch from `gh pr view --json baseRefName` when there is a PR, otherwise the repository's default branch. Use `git merge-base HEAD <base>`.
- Collect the commits (`git log --oneline HEAD --not <base>`), the changed production files, the changed test files, and the existing tests that exercise the changed production code.

## 2. Run both reviews in review-only mode

Start two subagents in the same turn with the Task tool, so they run in parallel. Give each one the same scope from step 1, tell it to load its skill with the skill tool, to run in review-only mode, not to edit any file, and to return every finding in the "Review findings" format from `_shared/testing-rules.md`, including `keep` and `uncertain` findings for the changed tests.

- Gap review: load `test-review`. Review the commits and changed production files for missing or weak coverage.
- Value review: load `review-test-value`. Review the changed test files and the existing tests that exercise the changed production code.

## 3. Reconcile by contract

Group findings that name the same contract, or that name the same test. When unsure whether two contracts are the same, keep them as separate groups and note it. A group with findings from only one review passes through unchanged. For a group with findings from both reviews, choose one action with the first rule that applies:

1. Either finding is `uncertain`: keep the test and list the group under "Needs human" with both findings.
2. Value says `remove` for a test, and the gap review asks to add, extend or rewrite coverage for the same contract: if the gap finding names a contract, a defect and an input that tells the right result from the wrong one, the action is `rewrite`, because the contract is real and the current test fails to protect it. Otherwise the action is `remove`.
3. Value says `merge`, gap says `extend` or `rewrite` for one of the merged tests: the action is `merge`, and the gap's case or assertion goes into the surviving test.
4. Gap says `add`, and the value review shows an existing test already catches the same defect: drop the `add`. If that test only covers neighbouring behaviour, the action is `extend` on it.
5. Value says `move` for a test the gap review wants to change or extend: the action is `move`, and the gap's case is written at the target layer.
6. The reviews disagree about the layer: apply the shared rule to choose the lowest sufficient layer. Keep one connected feature test for each critical journey, such as auth, webhooks, email sends or job triggers, and put the detailed cases at the lower layer.
7. Anything else: the finding with stronger evidence wins. A named contract, defect and discriminating input beats a finding without them, and an executed check beats inspection. When the evidence is equal, choose the action that keeps coverage, because a missed regression costs more than test maintenance.

## 4. Report

Keep the report in the response unless the user asks for a file. Include:

- Scope reviewed: base, commits, and the production and test files covered by each review.
- Findings: one table row per contract with the shared fields and the final action, ordered by business risk. Mark which review each finding came from, or "both".
- Conflicts resolved: for each group where the reviews disagreed, both original findings in one line each, the rule from step 3 that decided it, and the final action.
- Needs human: uncertain groups and any contract you could not match with confidence.
- A statement that tests were only reviewed, not changed.

## Applying the plan

Change tests only when the user asks. Then apply the reconciled plan as one batch on one branch, following the cleanup safeguards in `_shared/testing-rules.md`: write `add`, `extend` and `rewrite` actions before the `merge`, `move` and `remove` actions that depend on them, and run the affected tests. Deliver it the way `test-review` write mode does: one `tests/{branch}-gaps` branch and one PR, with merged, moved and removed tests listed in the PR body next to the tests added.
