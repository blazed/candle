# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.


## Key Commands
- `nix build` - Build the candle nixvim configuration
- `nix run` - Run the built neovim configuration
- `nixfmt` - Format Nix code
- `nix flake check` - Validate flake and run checks

## Code Style Guidelines

- Nix files: Format with nixfmt (RFC style)
- Use statix for Nix linting and deadnix to detect unused code
- Follow modular architecture in `modules/` for Neovim configuration
- Individual plugins should be configured in separate directories under `plugins/`
- Luacheck is used for Lua files
- For TypeScript/JavaScript use biome for formatting
- Follow existing naming conventions when adding new modules or plugins

## Development Workflow

- Make changes in appropriate module files
- Run `deadnix -e` and `statix fix .` before committing
- Verify changes with `nix flake check`
- Test by running `nix run` to activate the configuration
