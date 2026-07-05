---
name: basecode:nested-code
description: Apply the BaseCode Nested Code practice — flatten structure using guard clauses, conditional boolean returns, and higher-order functions to bring the primary action to the top level.
---

# BaseCode: Nested Code

Apply the BaseCode Nested Code practice to improve the readability of the code under review. The goal is not shorter code or personal style — it is **readability**: making the code easier for the next human to read.

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
