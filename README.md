# claude-code-skills

A personal [Claude Code](https://claude.com/claude-code) plugin marketplace.

## Install

```
/plugin marketplace add xtremeandroid/claude-code-skills
```

A local path works too:

```
/plugin marketplace add /Users/ayush/dev/claude-code-skills
```

## Layout

```
.claude-plugin/marketplace.json     # marketplace manifest, lists plugins
```

## Adding a plugin

1. Create `plugins/<name>/.claude-plugin/plugin.json` with `name`, `description`, and `version`.
2. Add `skills/<skill-name>/SKILL.md`, `commands/*.md`, `agents/*.md`, or `hooks/hooks.json` under the plugin directory.
3. Register it in the `plugins` array of `.claude-plugin/marketplace.json`:

   ```json
   { "name": "<name>", "source": "./plugins/<name>", "description": "..." }
   ```

4. Run `/plugin marketplace update claude-code-skills` to pick up changes.
