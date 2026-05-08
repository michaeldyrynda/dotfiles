# Solo MCP Integration

Shared instructions for skills that sync with Solo's todo and scratchpad systems. Each section is scoped to the skill that reads it — follow only the section relevant to your current role.

## Conventions

- **Project resolution:** Check the spec file's YAML frontmatter for `solo_project_id`. If present, call `mcp__solo__select_project` with that ID. If not present (or no spec exists yet), call `mcp__solo__list_projects` and select the project whose name matches the current working directory (auto-selects if only one exists).
- **Plan tagging:** All todos and scratchpads for a plan use the tag `plan:{slug}` where `{slug}` is the plan directory name.
- **Todo titles:** Prefixed with the zero-padded task number: `001: Implement POST /deals endpoint`.
- **Frontmatter fields:** `solo_project_id` lives in `spec.md` frontmatter. `solo_todo_id` and `solo_slug` live in each task file's frontmatter. `solo_slug` is the `url` value returned by `todo_create` (rich mode) or `todo_get` — a `solo://` deeplink.

---

## to-spec

After writing the spec file and scaffolding the plan directory:

1. **Resolve the project** per the conventions above.
2. **Write `solo_project_id` into the spec frontmatter.** Format:
   ```
   ---
   solo_project_id: {project_id}
   ---
   ```
   If Solo MCP is not available, omit the frontmatter entirely — no empty `---` blocks.
3. **Sync to scratchpad.**
   - Call `mcp__solo__scratchpad_list` with `tags: ["spec"]` to check for an existing scratchpad matching the plan slug.
   - If found, call `mcp__solo__scratchpad_write` to replace its content with the spec body.
   - If not found, call `mcp__solo__scratchpad_write` to create one with `name`: the plan slug, `content`: the full spec body, `tags`: `["spec", "plan:{slug}"]`.

---

## task-planner

After writing all task files (end of Phase 3):

1. **Resolve the project** per the conventions above (read `solo_project_id` from the spec's frontmatter).
2. **Create todos.** For each task file, call `mcp__solo__todo_create` with:
   - `title`: task number prefix + title (e.g. `001: Implement POST /deals endpoint`)
   - `body`: the task description and acceptance criteria
   - `tags`: `["plan:{slug}"]`
   - `priority`: `"medium"`
   - `response_mode`: `"rich"`
   Collect the returned `todo_id` and `url` for each task.
3. **Write `solo_todo_id` and `solo_slug` back to each task file's frontmatter.** Add them after the existing fields:
   ```
   ---
   dependencies: [1, 3]
   status: pending
   number: 5
   solo_todo_id: 42
   solo_slug: "solo://proj/3/todo/001-implement-post-deals--42"
   ---
   ```
4. **Wire up blockers.** For each task with `dependencies`, call `mcp__solo__todo_set_blockers` with:
   - `todo_id`: this task's todo_id
   - `blocker_ids`: the todo_ids of the dependency tasks (mapped from task numbers)

---

## task-implementor

### Boot (after reading all task files)

- **Detect Solo MCP** and check the spec's frontmatter for `solo_project_id`. If present, call `mcp__solo__select_project`. Remember this availability flag.
- **Read `solo_todo_id` and `solo_slug`** from each task file's frontmatter (already extracted in the task index).

### Mark in_progress (step 5)

- If Solo MCP is available and the selected task has `solo_todo_id`, call `mcp__solo__todo_update` with that `todo_id` and `status: "in_progress"`.

### Record (after updating task status)

- If Solo MCP is available and the task has `solo_todo_id`:
  - `complete` → call `mcp__solo__todo_complete` with `todo_id` and `completed: true`.
  - `failed` → call `mcp__solo__todo_comment_create` with `todo_id` and a `body` summarising the failure reason.
