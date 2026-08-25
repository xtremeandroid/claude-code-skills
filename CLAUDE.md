# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A personal Claude Code plugin marketplace. There is no build, no test suite, and no runtime code — the entire repo is JSON manifests plus Markdown skill prompts that Claude Code loads directly. "Correctness" means valid JSON, a valid `SKILL.md` frontmatter block, and manifests that agree with each other.

## Architecture

Three layers, each of which must stay in sync when anything changes:

1. `.claude-plugin/marketplace.json` — the marketplace manifest. Its `plugins` array maps a plugin `name` to a `source` path (`./plugins/<name>`) and repeats the plugin's description. `metadata.version` versions the marketplace as a whole.
2. `plugins/<name>/.claude-plugin/plugin.json` — the per-plugin manifest (`name`, `description`, `version`, `author`).
3. `plugins/<name>/skills/<skill>/SKILL.md` — the actual behavior. YAML frontmatter (`name`, `description`) is the only thing Claude sees until the skill fires; the `description` doubles as the trigger surface, so it must list both the slash commands and the natural-language phrases that should invoke it. Everything below the frontmatter is prompt text executed by the model — commands are Markdown sections (`### /<skill> <command>`), not code.

A plugin may also carry `commands/*.md`, `agents/*.md`, or `hooks/hooks.json`; none exist yet.

## Versioning (required before every push)

Any change to a plugin bumps **both**:

- `plugins/<name>/.claude-plugin/plugin.json` → `version`
- `.claude-plugin/marketplace.json` → `metadata.version`

Do this as part of the change, not as a follow-up commit — installed marketplaces only pick up updates when the version moves.

## Editing skills

- Make **small, targeted edits**. Do not rewrite a `SKILL.md` wholesale unless the user asks for it; these files are tuned prompts and a rewrite silently changes behavior far beyond the requested fix.
- Keep plugins **concise**. Prefer trimming to adding. Every line of `SKILL.md` is context spent on every invocation.
- When a plugin's description changes, update it in `plugin.json`, `marketplace.json`, and the `SKILL.md` frontmatter — all three carry a copy.

## Verify

```
python3 -m json.tool .claude-plugin/marketplace.json >/dev/null
python3 -m json.tool plugins/<name>/.claude-plugin/plugin.json >/dev/null
```

Then, in a Claude Code session: `/plugin marketplace update claude-code-skills` to reload, and invoke the skill (e.g. `/job-skill help`) to confirm it triggers.
