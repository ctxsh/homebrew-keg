.PHONY: brew-style
brew-style:
	@brew style .

.PHONY: brew-style-fix
brew-style-fix:
	@brew style --fix .

.PHONY: seactl-bump-to-latest
seactl-bump-to-latest:
	@./scripts/bump-to-latest.sh seactl seaway

.PHONY: genie-bump-to-latest
genie-bump-to-latest:
	@./scripts/bump-to-latest.sh genie genie