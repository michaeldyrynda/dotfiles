---
name: basecode:removing-comments
description: Apply the BaseCode Removing Comments practice — delete what- and how-comments, improve names in their place, and keep only why-comments that explain non-obvious constraints.
---

# BaseCode: Removing Comments

Apply the BaseCode Removing Comments practice to improve the readability of the code under review. The goal is not shorter code or personal style — it is **readability**: making the code easier for the next human to read.

Every inline comment is a cost to the reader. Remove comments that do not earn their place.

**Remove what-comments** — any comment that only restates what the next line of code does should be deleted. If the code cannot explain itself, improve the code (rename, extract a method, restructure) rather than add a comment.

**Remove how-comments** — comments explaining implementation details indicate an opportunity to extract a well-named method or improve naming so the intent is self-evident.

**Improve names, then remove the comment** — when a comment describes a variable's purpose, use that description as the variable's name and delete the comment.

**Keep why-comments** — a comment explaining a non-obvious constraint, a workaround, a hidden business rule, or the reason a specific API endpoint was chosen over another has earned its place. Rewrite it in clear English if it is vague or grammatically incorrect.

**Apply proximity** — move a variable declaration close to where it is first used so the reader does not need a comment to maintain context.
