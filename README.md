---

# GitHub Project Push Script

---

This script automates the process of pushing your project to GitHub using a Personal Access Token (PAT). It allows you to easily update your GitHub repositories without manually configuring Git settings every time.

## Prerequisites

Before using this script, make sure you have the following:

1. **Git**: Git should be installed on your system.

2. **GitHub Account**: You should have a GitHub account.

3. **Personal Access Token (PAT)**: Generate a GitHub PAT with the "repo" scope. This token is required for authentication when pushing to GitHub.

## Cloning the Repository

To get started, clone this repository to your local machine by running the following command:

```bash
git clone https://github.com/OusamaTheCoder/Github-Automation.git
```

## Getting Started

1. Move the `github.sh` script to a directory included in your system's `PATH`. You can use `~/bin` as a common choice.

   ```bash
   mv github.sh ~/bin/
   ```

2. Add the directory containing the script to your system's `PATH`. You can do this by adding the following line to your shell profile file (e.g., `~/.bashrc`, `~/.bash_profile`, or `~/.zshrc`, depending on your shell).

   ```bash
   export PATH="$PATH:$HOME/bin"
   ```

   If you're using `bash`, you can add it to `~/.bashrc` like this:

   ```bash
   echo 'export PATH="$PATH:$HOME/bin"' >> ~/.bashrc
   ```

   If you're using `zsh`, you can add it to `~/.zshrc` like this:

   ```bash
   echo 'export PATH="$PATH:$HOME/bin"' >> ~/.zshrc
   ```

   Remember to reload your shell profile or restart your terminal for the changes to take effect.

3. Make the script executable:

   ```bash
   chmod +x ~/bin/github.sh
   ```

## Usage

Once the script is set up, you can use it to push your project to GitHub. Here's how:

```bash
github.sh "Your commit message"
```

- If you've used the script before, it will use the settings saved in the `github_settings.txt` file.

- If it's your first time or you choose to update settings, the script will prompt you for your GitHub username, repository name, local project path, and PAT with 'repo' scope. These settings will be saved for future use.

## Author

- `[Ousama]`(<https://github.com/OusamaTheCoder>)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Inspiration for this project (Thank you, night and songs, for the late-night coding inspiration!).
- GitHub API documentation.