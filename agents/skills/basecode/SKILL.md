---
name: basecode
description: Apply BaseCode practices to improve the readability of code — naming, dead code, nested code, comments, and more.
---

# BaseCode Review

Apply the BaseCode practices in order to improve the readability of the code under review. Work through each practice as a discrete pass. The goal is not shorter code or personal style — it is **readability**: making the code easier for the next human to read.

## 1. Formatting

Apply the standard formatter for the language and move on. Do not debate style.

- Run the language's canonical formatter (Prettier, gofmt, Black, php-cs-fixer, etc.)
- Ensure indentation, brace placement, and spacing are consistent throughout
- Goal: "visual honesty" — the visual structure should match the logical structure
- Do not spend time on formatting that a tool can automate

## 2. Dead Code

Remove all code that is not executed or no longer serves a purpose. Dead code creates noise, signals neglect, and misleads readers.

**Commented-out code** — delete it. It exists in version control; if it's needed again, revert.

**Unused code** — remove parameters, variables, methods, and imports that are never referenced. Use static analysis to find them.

**Unreachable code** — remove code that can never execute:
- `break` after `return` inside a `switch`/`case`
- Code below a top-level `return` in a function
- Conditions that always evaluate to `false`
- Loops that never run

**Abandoned code** — identify conditional paths gated on config values, feature flags, or preferences that are permanently off or no longer exist, and remove the entire dead branch.

## 3. Nested Code

Reduce nesting to bring the primary action of a function to the top level. Each nesting level adds mental overhead for the reader.

**Empty blocks** — remove empty `if` or `else` blocks entirely. Invert the condition if needed.

**Conditional boolean returns** — when an `if/else` returns `true`/`false` directly, replace it with a single `return` of the condition expression:
```
// before
if ($x === 0) { return true; } else { return false; }

// after
return $x === 0;
```

**Guard clauses** — convert nested `if` blocks into early returns. Negate the condition and return (or throw) to protect the rest of the function:
```
// before
if ($item !== null) {
    if (!$this->contains($item)) {
        $this->items[] = $item;
    }
}

// after
if ($item === null || $this->contains($item)) {
    return;
}
$this->items[] = $item;
```

**Switch to if** — prefer `if` chains over `switch` when: there are only 2–3 cases, case blocks contain nested code, or the switch requires type coercion. Keep `switch` when a clean 1:1 ratio exists between cases and single-line bodies.

**Loops** — prefer higher-order functions (`filter`, `map`, `reduce`) over manual loops when the intent is accumulation or transformation.

## 4. Using Objects

Replace informal data structures with objects when primitives make the code harder to maintain or read.

**Formalize arrays/dictionaries** — when an associative array is passed around with a fixed set of known keys, replace it with a class that declares those properties explicitly.

**Couple data clumps** — when two or more values are always passed together (e.g., `$amount` and `$currency`, `$min` and `$max`), introduce a value object that holds both. Once coupled, make the object immutable.

**Encapsulate logic** — move logic that operates on an object's data into the object itself. If the same comparison or calculation appears in multiple places referencing the same data, it belongs as a method on that object.

Only introduce objects when they reduce complexity. If primitives keep the code clear, leave them.

## 5. Big Blocks

When a function or method is too long to read at a glance, apply this three-step process:

**Step 1 — Recognize the level.** What is the context of this code? (controller, model, service, utility?) What does a reader expect to find here? Anything above or below that expectation is noise.

**Step 2 — Regroup into sub-blocks.** Add blank lines between logical groupings, then add a temporary comment to each group describing its action in plain English. This outlines what the code does and makes duplication visible.

**Step 3 — Refactor each sub-block.** For each labeled group, ask two questions:
1. Is there a more *native* way to handle this? (Search the codebase, framework, or language docs using the comment label as keywords.)
2. Does this action fit the current level? If not, move it to the appropriate level (extract a private method, push logic to a model, delegate to a helper).

Remove temporary comments once the refactor communicates the same intent through code. Keep a comment only if it survived the challenge in step 3.

## 6. Naming

Names carry the most human signal in code. Apply these rules in order.

**Avoid abbreviations** — use complete words. `$user`, not `$u`. `$destination`, not `$dst`. No single-letter names except the conventional `$i`, `$j` in `for` loops.

**Follow conventions** — adopt the naming conventions of the language (e.g., `$i` for loop index, interface prefix `I` in .NET, camelCase vs snake_case). Do not invent new conventions when a standard exists.

**Leverage context** — do not repeat context already obvious from the surrounding scope. A `name` column in a `users` table does not need to be `user_name`. A property inside a `Money` class does not need to be `money_amount`. Use the freed characters to enrich the name instead.

**Human readable** — names should read like natural language. Aim for names that form a sentence when read with their caller: `$course->enrollUser($user)` reads as a sentence; `$c->eu($u)` does not.

**Express the domain** — prefer vocabulary from the problem domain over technical vocabulary. `Zookeeper` and `feed` communicate more than `Employee` and `work`. Use a thesaurus when stuck.

**Allow time** — do not force a name on the first pass. Use a long, descriptive temporary name (even a full phrase) if needed. The right name often emerges after more of the code is written and the domain vocabulary becomes clearer.

## 7. Removing Comments

Every inline comment is a cost to the reader. Remove comments that do not earn their place.

**Remove what-comments** — any comment that only restates what the next line of code does should be deleted. If the code cannot explain itself, improve the code (rename, extract a method, restructure) rather than add a comment.

**Remove how-comments** — comments explaining implementation details indicate an opportunity to extract a well-named method or improve naming so the intent is self-evident.

**Improve names, then remove the comment** — when a comment describes a variable's purpose, use that description as the variable's name and delete the comment.

**Keep why-comments** — a comment explaining a non-obvious constraint, a workaround, a hidden business rule, or the reason a specific API endpoint was chosen over another has earned its place. Rewrite it in clear English if it is vague or grammatically incorrect.

**Apply proximity** — move a variable declaration close to where it is first used so the reader does not need a comment to maintain context.

## 8. Reasonable Returns

Avoid returning values that force the caller to write extra handling code. `null` is the most common offender.

**Return empty primitives instead of null** — when a function returns a collection, return `[]` not `null`. When it returns a number, return `0`. When it returns a string, return `""`. Match the return type to the primary action of the function. Fix the lowest-level functions first; this prevents null-handling from propagating upward.

**Use expressive values** — replace magic numbers (`-1`, `0`, `1`) with named constants or enums. `NSNotFound` communicates more than `-1`. Define the constant once and reference it everywhere.

**Use null objects** — when a function must return an object but has nothing to return, create a null object that implements the same interface with safe empty-value behavior. Return the null object instead of `null`, eliminating the caller's need for a null check.

## 9. Rule of Three

Do not abstract duplication immediately. Premature abstraction is more harmful than duplication.

- **First occurrence** — write it. No abstraction yet.
- **Second occurrence** — duplicate it. Note the duplication but leave it.
- **Third occurrence** — now refactor. By this point the pattern is clear and the correct abstraction is knowable.

The principle is **Defer Until Necessary (DUN)**. Duplication is far cheaper than the wrong abstraction. Allowing duplication to stand gives time for the pattern to emerge naturally. When you do refactor, you will have multiple concrete examples to inform the correct abstraction rather than speculating from one.

Do not reset this counter when the code changes. If a pattern appears only twice, leave it.

## 10. Symmetry

Apply symmetry last. Once all other practices have been applied, look at the code as a whole and ask: does the same idea appear the same way everywhere?

**Syntactic symmetry** — consistent formatting and structure throughout. Curly braces, operator choice (`&&` vs `and`), declaration placement — pick one style and apply it uniformly.

**Semantic symmetry** — name pairs should be proper opposites: `on`/`off`, `push`/`pop`, `enable`/`disable`. Prefix conventions must be consistent: if boolean methods use `is` prefix, use it everywhere. Keep conditional tone consistent — if the guard clauses all read positively (`disabled()`, `firstRun()`), do not mix in negated expressions (`!$this->enabled`).

**Systemic symmetry** — abstraction levels within a function should be consistent. Do not mix high-level method calls with low-level implementation details at the same level (e.g., `$count++` among `input()` and `output()` calls). Extract the low-level detail to match the surrounding level. Prefer reusing an existing pattern in the codebase over introducing a new one.

Symmetry is a feedback loop: as you improve one part, asymmetries elsewhere become more visible. Stop when the code flows naturally for the reader.

---

## Order of application

Apply the practices in this order — each pass sets up the next:

1. Formatting — establish visual honesty
2. Dead Code — remove noise
3. Nested Code — flatten structure
4. Using Objects — formalize data
5. Big Blocks — reduce and delegate
6. Naming — enrich human signal
7. Removing Comments — force code to speak for itself
8. Reasonable Returns — clean up return values
9. Rule of Three — address earned duplication
10. Symmetry — make the whole consistent

After completing a pass, re-examine earlier passes. Refactoring at one level often surfaces new opportunities at others.
