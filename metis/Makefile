# Configuration des répertoires
DIRECTORIES := \
    ./api-aerial/src \
    ./api-dashboard/src \
    ./front-dashboard/src \
    ./front-reservation/src

# Commandes communes
GIT_PULL = git pull origin development
NPM_INSTALL = npm install --legacy-peer-deps

# Nettoyage des branches
.PHONY: clean-branches
clean-branches:
	@echo "Nettoyage des branches..."
	@INITIAL_DIR=`pwd`; \
	for dir in $(DIRECTORIES); do \
		echo "Traitement de $$dir..."; \
		if [ -d "$$dir/../.git" ]; then \
			cd $$dir && \
			git fetch --prune && \
			git branch --merged | grep -vE '(^\*|main|master|development)' | xargs -r git branch -d && \
			git remote prune origin && \
			$(GIT_PULL) && \
			$(NPM_INSTALL) && \
			cd $$INITIAL_DIR; \
		else \
			echo "$$dir n'est pas un dépôt Git"; \
		fi; \
	done
