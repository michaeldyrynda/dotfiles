---
name: Task Writer
team: planning
type: template

description: Formats structured task JSON into individual markdown task files

input:
  tasks:
    description: Array of task objects from the Task Detailer
    required: true
  output_dir:
    description: Directory to write task files into
    default: .ai/tasks

output:
  path: "{{output_dir}}/{{number}}.md"
  naming: zero-padded 3-digit task number (001.md, 002.md, ...)

numbering:
  start: 1
  description: >-
    Task numbers are 1-indexed to match filenames.
    The depends_on array from the detailer is 0-indexed;
    add 1 to each value when writing the dependencies field.
---

## Template

```markdown
---
dependencies: {{dependencies}}
status: pending
number: {{number}}
---
Title: {{title}}
Description:
{{description}}

Acceptance Criteria:
{{acceptance_criteria}}
```

## Field mapping

| Template field       | Source                                          |
|----------------------|-------------------------------------------------|
| `number`             | Outline index + 1, zero-padded to 3 digits      |
| `dependencies`       | `task.depends_on` mapped from 0-indexed to 1-indexed |
| `status`             | Always `pending` on initial generation           |
| `title`              | `task.title`                                     |
| `description`        | `task.description`                               |
| `acceptance_criteria`| `task.acceptance_criteria`                       |

## Behaviour

1. Create `{{output_dir}}` if it does not exist.
2. For each task at outline index `i`:
   - Compute `number = i + 1`.
   - Map `depends_on` entries: each index `d` becomes `d + 1`.
   - Format the dependencies array as a YAML list (e.g. `[1, 3]` or `[]`).
   - Render the template and write to `{{output_dir}}/{{number | pad 3}}.md`.
3. All writes are independent and can run in parallel.
