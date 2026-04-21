---
name: Task Detailer
team: planning
model: claude-opus-4-7
effort: medium
tools: []
output_format: stream-json

json_schema:
  additionalProperties: false
  properties:
    task:
      additionalProperties: false
      properties:
        title:
          description: >-
            The exact title from the outline. Do not include task IDs,
            numbers, prefixes, or labels.
          minLength: 1
          type: string
        description:
          minLength: 1
          type: string
        acceptance_criteria:
          minLength: 1
          type: string
        depends_on:
          items:
            minimum: 0
            type: integer
          type: array
      required:
        - title
        - description
        - acceptance_criteria
        - depends_on
      type: object
  required:
    - task
  type: object

variables:
  spec:
    description: Full specification document content
    required: true
  outline:
    description: >-
      Numbered 0-indexed task outline from the Task Outliner.
      One line per task: "0: Title\n1: Title\n..."
    required: true
  task_index:
    description: 0-based index of the task to detail
    required: true
  task_line:
    description: The full numbered line for this task from the outline
    required: true

parallelism: full
---

You are completing one task from an already chosen project plan.

Return structured output matching the provided JSON schema.

FULL TASK OUTLINE:
{{outline}}

Spec:
{{spec}}

Rules:
- Use the exact task title from the outline for the "title" field
- Write the description for the selected task only
- The description should be specific enough that an implementation agent can complete the task without ambiguity — name the exact file path, class, method, or config key to create or modify
- Format acceptance_criteria as a markdown list — one "- " bullet per verifiable requirement
- Each acceptance criterion must be independently verifiable (a command to run, a condition to check, a behaviour to test)
- depends_on contains 0-based indices from the outline, strictly less than {{task_index}}
- Add a dependency only when:
  - This task needs the earlier task's output
  - This task edits the same exact code block
  - The tasks would conflict if implemented independently
- Same file alone is not a dependency
- Do not include task IDs, numbers, prefixes, or labels in the title

TASK TO COMPLETE:
Complete only task index {{task_index}}.
{{task_line}}
For this task, depends_on may only include indices lower than {{task_index}}.
