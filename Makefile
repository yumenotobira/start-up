.DEFAULT_GOAL := setup

.PHONY: setup
setup: switch setup-pnpm install-global-tools

.PHONY: switch
switch:
	home-manager switch -b backup --flake .#default --impure

PNPM_HOME := $(HOME)/.local/share/pnpm
PNPM_ENV := PNPM_HOME="$(PNPM_HOME)" PATH="$(PNPM_HOME):$$PATH"

.PHONY: setup-pnpm
setup-pnpm:
	mkdir -p "$(PNPM_HOME)"
	$(PNPM_ENV) pnpm config set global-bin-dir "$(PNPM_HOME)"
	$(PNPM_ENV) pnpm config set --global minimumReleaseAge 4320

.PHONY: install-global-tools
install-global-tools:
	$(PNPM_ENV) pnpm add -g @github/copilot
	$(PNPM_ENV) pnpm add -g @openai/codex
	$(PNPM_ENV) pnpm add -g --allow-build=@ast-grep/cli @ast-grep/cli
	curl -fsSL https://claude.ai/install.sh | bash

