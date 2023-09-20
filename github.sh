#!/bin/bash

# Function to display a message in yellow
function echo_yellow {
  YELLOW='\033[1;33m'
  NC='\033[0m' # No Color
  echo -e "${YELLOW}$1${NC}"
}

# Display a brief description of the script for the user in yellow
echo_yellow "########################################|| GitHub Project Push Script ||########################################"
echo_yellow "# This script automates the process of pushing your project to GitHub using a Personal Access Token (PAT)      #"
echo_yellow "# It allows you to easily update your GitHub repositories without manually configuring Git settings every time #"
echo_yellow "################################################################################################################"

echo ""


# Function to display a loading spinner
function loading_spinner {
  local pid=$!
  local delay=0.2
  local spin_chars="/-\|"
  while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
    local spin_char="${spin_chars:i++%${#spin_chars}:1}"
    echo -ne "Pushing to GitHub... $spin_char" "\r"
    sleep $delay
  done
  echo -ne "Pushing to GitHub... Done!    \n"
}

# Check if settings file exists and load settings
SETTINGS_FILE="github_settings.txt"
if [ -f "$SETTINGS_FILE" ]; then
  source "$SETTINGS_FILE"
else
  # If the settings file does not exist, use default values
  USERNAME="YourGitHubUsername"
  REPO_NAME="YourRepositoryName"
  PROJECT_PATH="/path/to/your/project"  # Update with your default project path
  PAT_TOKEN=""
fi

# Check if the user wants to update settings
read -p "Do you want to update settings (GitHub username, repository name, local path, PAT token)? (y/n): " UPDATE_SETTINGS

if [ "$UPDATE_SETTINGS" = "y" ]; then
  # Prompt user for GitHub username
  read -p "Enter your GitHub username: " USERNAME

  # Prompt user for GitHub repository name
  read -p "Enter your GitHub repository name: " REPO_NAME

  # Prompt user for the local path to the project
  read -p "Enter the local path to your project: " PROJECT_PATH

  # Prompt user for a personal access token (PAT) with the "repo" scope
  read -s -p "Enter your GitHub PAT with 'repo' scope: " PAT_TOKEN
  echo

  # Save updated settings to the file
  echo "USERNAME=\"$USERNAME\"" > "$SETTINGS_FILE"
  echo "REPO_NAME=\"$REPO_NAME\"" >> "$SETTINGS_FILE"
  echo "PROJECT_PATH=\"$PROJECT_PATH\"" >> "$SETTINGS_FILE"
  echo "PAT_TOKEN=\"$PAT_TOKEN\"" >> "$SETTINGS_FILE"
fi

# Check if a commit message is provided as an argument
if [ $# -eq 0 ]; then
  read -p "Enter a commit message: " COMMIT_MESSAGE
else
  COMMIT_MESSAGE="$1"
fi

# Navigate to the project directory
cd "$PROJECT_PATH" || exit

# Initialize a Git repository if not already done
if [ ! -d .git ]; then
  git init
fi

# Check if user identity is set, and if not, provide instructions
if [ -z "$(git config user.name)" ] || [ -z "$(git config user.email)" ]; then
  echo "Git user identity is not set. Please run the following commands and restart the script:"
  echo "  git config --global user.email 'you@example.com'"
  echo "  git config --global user.name 'Your Name'"
  exit 1
fi

# Add all changes and commit with the provided message
git add .
git commit -m "$COMMIT_MESSAGE"

# Set the remote repository URL with the PAT
REMOTE_REPO="https://$USERNAME:$PAT_TOKEN@github.com/$USERNAME/$REPO_NAME.git"
git remote add origin "$REMOTE_REPO"

# Push to GitHub in the background
git push -u origin master &
loading_spinner

# Check if the push was successful
if [ $? -eq 0 ]; then
  echo "Project successfully pushed to GitHub."
else
  echo "Failed to push project to GitHub."
fi
