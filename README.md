# LLM Shell Scripts

Welcome to the **LLM Shell Scripts** collection! This repository offers a set of shell scripts that leverage Large Language Models (LLMs) to automate tasks directly from the command line.

Whether you need to generate Git commit messages, create GitHub PRs, or integrate other powerful LLM features into your workflow, you're in the right place. 🚀

______________________________________________________________________

## 🔧 **Required Tools**

To use these scripts, you need access to an LLM from the command line interface (CLI).

### Available Options:

- **[LLM](https://llm.datasette.io/en/stable/)**: A versatile tool for running LLMs locally or remotely.
- **[LLM Plugins Directory](https://llm.datasette.io/en/stable/plugins/directory.html)**: A wide selection of plugins for different LLMs.
- **[Ollama](https://github.com/taketwo/llm-ollama)**: For running models in regulated or closed environments (self-hosted).

Once you've set up your desired LLM, you're ready to run these scripts and enhance your workflow! 🌟

______________________________________________________________________

## 📝 **Available Scripts**

Here are the current scripts available in the repo. These scripts aim to streamline your Git and GitHub workflow with AI-powered automation:

| **Script** | **Description** |
| ---------- | --------------- |
| [git-commit](./git/git-commit.zsh) | Generate a Git commit message using LLM. 📝 |
| [github-pr](./git/github-pr.zsh) | Create a GitHub Pull Request with an AI-generated message. 🔄 |

Each script is designed to be simple to use while saving you time and effort by automating common tasks!

______________________________________________________________________

## 🚀 **How to Use**

### 1. **Clone the Repository:**

First, clone the repository to your local machine.

```bash
git clone https://github.com/your-username/llm-shellscripts.git
cd llm-shellscripts
```

### 2. **Install Dependencies:**

Before using the scripts, make sure you have the following tools set up:

- **LLM** (from [datasette.io](https://llm.datasette.io/en/stable/)).
- Optionally, **Ollama** for self-hosted or regulated environments.

Check the installation guides for [LLM](https://llm.datasette.io/en/stable/) and [Ollama](https://github.com/taketwo/llm-ollama) for detailed steps.

### 3. **Run the Scripts:**

Now, you’re ready to use the scripts! Depending on your shell environment, the process is slightly different. Here's how to run the scripts:

#### For **zsh and **bash :**

If you're using **zsh** (which is the default on newer macOS and many Linux distros), simply execute the scripts like this:

```bash
source ./git/git-commit.zsh
```

Though these scripts are written for **zsh**, they are generally compatible with **bash** as well. However, certain **zsh**-specific features (e.g., custom autocompletions) may not work perfectly in **bash**.

#### For **Oh My Zsh:**

If you're using **[Oh My Zsh](https://ohmyz.sh/)**, you’ll enjoy the added benefits of autocompletion and custom plugins. You can easily run the scripts the same way as with **zsh**:

```bash
source ./git/git-commit.zsh
```

Additionally, you can add these scripts to your **Oh My Zsh** custom plugins to make them even more accessible! Here’s how you can add a custom plugin:

1. Create a new folder for custom scripts inside your **Oh My Zsh** configuration:

   ```bash
   mkdir ~/.oh-my-zsh/custom/plugins/llm-scripts
   ```

2. Copy the scripts into this folder:

   ```bash
   cp ./git/*.zsh ~/.oh-my-zsh/custom/plugins/llm-scripts/
   ```

3. Add the plugin to your `.zshrc` file:

   ```bash
   plugins=(... llm-scripts)
   ```

4. Apply the changes by reloading your shell:

   ```bash
   source ~/.zshrc
   ```

Now, you can run the script function directly from your terminal without needing to navigate to the folder, like so:

```bash
git-commit
```

This can simplify and streamline your workflow significantly if you’re a heavy user of **Oh My Zsh**!

______________________________________________________________________

## 🌱 **Contributing**

Feel free to contribute to this project! Whether it’s improving existing scripts, adding new features, or fixing bugs, your contributions are always welcome.

### How to contribute

1. Fork the repository.
1. Create a new branch.
1. Make your changes.
1. Open a pull request.

______________________________________________________________________

## 📜 **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
