---
name: basecode:naming
description: Apply the BaseCode Naming practice — avoid abbreviations, follow conventions, leverage context, and use domain vocabulary to maximize human signal in names.
---

# BaseCode: Naming

Apply the BaseCode Naming practice to improve the readability of the code under review. The goal is not shorter code or personal style — it is **readability**: making the code easier for the next human to read.

Names carry the most human signal in code. Apply these rules in order.

**Avoid abbreviations** — use complete words. `$user`, not `$u`. `$destination`, not `$dst`. No single-letter names except the conventional `$i`, `$j` in `for` loops.

**Follow conventions** — adopt the naming conventions of the language (e.g., `$i` for loop index, interface prefix `I` in .NET, camelCase vs snake_case). Do not invent new conventions when a standard exists.

**Leverage context** — do not repeat context already obvious from the surrounding scope. A `name` column in a `users` table does not need to be `user_name`. A property inside a `Money` class does not need to be `money_amount`. Use the freed characters to enrich the name instead.

**Human readable** — names should read like natural language. Aim for names that form a sentence when read with their caller: `$course->enrollUser($user)` reads as a sentence; `$c->eu($u)` does not.

**Express the domain** — prefer vocabulary from the problem domain over technical vocabulary. `Zookeeper` and `feed` communicate more than `Employee` and `work`. Use a thesaurus when stuck.

**Allow time** — do not force a name on the first pass. Use a long, descriptive temporary name (even a full phrase) if needed. The right name often emerges after more of the code is written and the domain vocabulary becomes clearer.
