DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*) bin
EXCLUSIONS := .DS_Store .git .gitmodules .travis.yml
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

.DEFAULT_GOAL := help

all: brew_install brew_update install update ## initial execution

.PHONY: list
list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

.PHONY: brew_update
brew_update: brew_install ## update packages managed by brew and written in "Brewfile"
	@echo "run brew doctor ..."
	@which brew >/dev/null 2>&1 && brew doctor
	@echo "run brew update ..."
	@brew update
	@echo "ok. run brew upgrade ..."
	@brew upgrade
	@echo "run brew bundle ..."
	@brew bundle
	@echo "run brew cleanup ..."
	@brew cleanup

.PHONY: brew_install
brew_install: ## install brew if not
	@echo "installing Homebrew ..."
	@which brew >/dev/null 2>&1 || (/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)")

.PHONY: update
update: ## Create symlink to home directory
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

.PHONY: install
install: ## install something 

.PHONY: clean
clean: ## Remove the dot files and this repo
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTPATH)

.PHONY: help
help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'