---
name: basecode:dead-code
description: Apply the BaseCode Dead Code practice — remove commented-out code, unused code, unreachable code, and abandoned feature branches to reduce noise and improve readability.
---

# BaseCode: Dead Code

Apply the BaseCode Dead Code practice to improve the readability of the code under review. The goal is not shorter code or personal style — it is **readability**: making the code easier for the next human to read.

Remove all code that is not executed or no longer serves a purpose. Dead code creates noise, signals neglect, and misleads readers.

**Commented-out code** — delete it. It exists in version control; if it's needed again, revert.

**Unused code** — remove parameters, variables, methods, and imports that are never referenced. Use static analysis to find them.

**Unreachable code** — remove code that can never execute:
- `break` after `return` inside a `switch`/`case`
- Code below a top-level `return` in a function
- Conditions that always evaluate to `false`
- Loops that never run

**Abandoned code** — identify conditional paths gated on config values, feature flags, or preferences that are permanently off or no longer exist, and remove the entire dead branch.
