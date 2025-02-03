# Define directories
API_AERIAL_DIR=./api-aerial/src
API_DASHBOARD_DIR=./api-dashboard/src
FRONT_DASHBOARD_DIR=./front-dashboard/src
FRONT_RESERVATION_DIR=./front-reservation/src

# Define commands
GIT_PULL=git pull origin development
NPM_INSTALL=npm install --legacy-peer-deps
NPM_START=npm run dev
CHROME_OPEN=open -a "Google Chrome" http://localhost:3000

# Phony targets
.PHONY: all clean-branches

# Session name for tmux
SESSION_NAME=my_project

# Target to start all services in a single tmux session with 4 panes
all:
	@echo "Starting cleaning up unused local branches..."
	@make clean-branches
	@echo "Starting tmux session with 4 panes..."
	@tmux new-session -d -s $(SESSION_NAME) -n Main "cd $(API_AERIAL_DIR) && $(GIT_PULL) && $(NPM_INSTALL) && $(NPM_START)" \; \
		split-window -h "cd $(API_DASHBOARD_DIR) && $(GIT_PULL) && $(NPM_INSTALL) && $(NPM_START)" \; \
		split-window -v "cd $(FRONT_RESERVATION_DIR) && $(GIT_PULL) && $(NPM_INSTALL) && $(NPM_START)" \; \
		select-pane -t 0 \; \
		split-window -v "cd $(FRONT_DASHBOARD_DIR) && $(GIT_PULL) && $(NPM_INSTALL) && $(NPM_START)" \; \
		select-layout tiled \; \
		select-pane -t 2 \; \
		send-keys "$(CHROME_OPEN)" Enter \; \
		attach-session -t $(SESSION_NAME)

# Target to clean up unused local branches in all directories
clean-branches:
	@echo "Cleaning up unused local branches in all directories..."
	@for dir in $(API_AERIAL_DIR) $(API_DASHBOARD_DIR) $(FRONT_DASHBOARD_DIR) $(FRONT_RESERVATION_DIR); do \
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

