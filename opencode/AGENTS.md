# Global Knowledge Base

The user's common knowledge base is located at:
`/Users/parsadastjerdi/Documents/Obsidian/Main Vault`

This is the canonical source for personal notes, reference material, and general knowledge. When the user asks you to look up or remember something about themselves, their projects, or general topics, check this vault.

## Dotfiles

The user's dotfiles are managed at:
`/Users/parsadastjerdi/Work/dotfiles`

Files under `~/.config/opencode/` are symlinked into this repo (e.g. `opencode.json`, `AGENTS.md`, `package.json`).

## Linear Issue Conventions

When creating Linear issues, follow these rules:

1. Use `# Context` (what/why) and `# Action Items` (checklist of concrete steps) sections in every issue description.
2. Wire up dependency relations (`blocks` / `blockedBy`) between related issues so the order of work is clear.
3. Keep issues at a granularity where each is a single logical feature — don't split tightly coupled work into separate issues, don't lump independent work into one.
