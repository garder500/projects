# Configuration des répertoires
DIRECTORIES := \
    ./api-adhesion/src \
    ./front-adhesion/src

DIRECTORIES_MOBILE := \
	./api-tourcom-mobile/src \
	./api-tourcom-users/src

# Define commands
GIT_PULL=git pull origin development
GIT_PULL_API=git pull origin dev
NPM_INSTALL=npm ci --legacy-peer-deps
BUILD=npm run prebuild

# Target to launch properly the project
.PHONY: launch
launch:
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
	done && \
	for dir in $(DIRECTORIES_MOBILE); do \
		echo "Traitement de $$dir..."; \
		if [ -d "$$dir/../.git" ]; then \
			cd $$dir && \
			git fetch --prune && \
			git branch --merged | grep -vE '(^\*|main|master|development)' | xargs -r git branch -d && \
			git remote prune origin && \
			$(GIT_PULL_API) && \
			$(NPM_INSTALL) && \
			$(BUILD) && \
			cd $$INITIAL_DIR; \
		else \
			echo "$$dir n'est pas un dépôt Git"; \
		fi; \
	done
