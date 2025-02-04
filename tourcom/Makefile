# Define directories
API_ADHESION_DIR=./api-adhesion/src
API_TOURCOM_MOBILE_DIR=./api-tourcom-mobile/src
API_TOURCOM_USERS_DIR=./api-tourcom-users/src
FRONT_ADHESION_DIR=./front-adhesion/src

# Define commands
GIT_PULL=git pull origin development
GIT_PULL_API=git pull origin dev
NPM_INSTALL=npm ci --legacy-peer-deps
NPM_START=npm run dev
CHROME_OPEN=open -a "Google Chrome" http://localhost:3000
BUILD=npm run prebuild
# Phony targets
.PHONY: all clean-branches

# Session name for tmux
SESSION_NAME=tourcom

# Target to start all services in a single tmux session with 4 panes
all:
	@echo "Starting cleaning up unused local branches..."
	@make clean-branches
	@echo "Starting tmux session with 4 panes..."tmux list-sessions
	@tmux new-session -d -s $(SESSION_NAME) -n Main "bash -c 'cd $(API_ADHESION_DIR) && $(GIT_PULL) && $(NPM_INSTALL) && $(NPM_START); exec bash'" \; \
	split-window -h "bash -c 'cd $(API_TOURCOM_MOBILE_DIR) && $(GIT_PULL_API) && $(NPM_INSTALL) && $(BUILD) && $(NPM_START); exec bash'" \; \
	split-window -v "bash -c 'cd $(API_TOURCOM_USERS_DIR) && $(GIT_PULL_API) && $(NPM_INSTALL) && $(BUILD) && $(NPM_START); exec bash'" \; \
	select-pane -t 0 \; \
	split-window -v "bash -c 'export NODE_OPTIONS=--openssl-legacy-provider && cd $(FRONT_ADHESION_DIR) && $(GIT_PULL) && $(NPM_INSTALL) && $(NPM_START); exec bash'" \; \
	select-layout tiled \; \
	attach-session -t $(SESSION_NAME)

# Target to clean up unused local branches in all directories
clean-branches:
	@echo "Cleaning up unused local branches in all directories..."
	@for dir in $(API_ADHESION_DIR) $(API_TOURCOM_MOBILE_DIR) $(API_TOURCOM_USERS_DIR) $(FRONT_ADHESION_DIR); do \
	    echo "Cleaning branches in $$dir..."; \
	    if [ -d "$$dir/../.git" ]; then \
	        cd $$dir; \
	        git fetch --prune; \
	        git branch --merged | grep -vE '(^\*|main|master|development)' | xargs -r git branch -d; \
	        git remote prune origin; \
	        cd - > /dev/null; \
	    else \
	        echo "$$dir is not a Git repository. Skipping..."; \
	    fi; \
	done

