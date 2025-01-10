# Create a function to generate AI-powered commit messages using LLM
#
# based on the original X message from [Andrej Karpathy](https://karpathy.ai/)
#  Requires: 
#  - LLM installed and configured with your desired model <https://llm.datasette.io/en/stable/>
#
#  My personal preference is <https://github.com/angerman/llm-groq>. Groq has a collection of opensource models (llama/mistral)
#  a reasonable amount of free credits and above all it's super fast.


# -----------------------------------------------------------------------------
LLM_MODEL="gpt-4o-mini"                      # Replace with your desired model
#
# AWS_PROFILE=bedrockai llm -m mybedrockmodel 
# -----------------------------------------------------------------------------


git-commit() {
    # Check if there are any staged changes
    if [ -z "$(git diff --cached --name-only)" ]; then
        echo "No staged changes found. Please stage your changes before committing."
        return 1
    fi
    # Function to generate commit message
    generate_commit_message() {
        git diff --cached | llm -m $LLM_MODEL "
Below is a diff of all staged changes, coming from the command:
\`\`\`
git diff --cached
\`\`\`
Please generate a concise, one-line commit message for these changes."
    }
    # Function to read user input compatibly with both Bash and Zsh
    read_input() {
        if [ -n "$ZSH_VERSION" ]; then
            echo -n "$1"
            read -r REPLY
        else
            read -p "$1" -r REPLY
        fi
    }
    # Main script
    echo "Generating AI-powered commit message..."
    commit_message=$(generate_commit_message)
    while true; do
        echo -e "\nProposed commit message:"
        echo "$commit_message"
        read_input "Do you want to (a)ccept, (e)dit, (r)egenerate, or (c)ancel? "
        choice=$REPLY
        case "$choice" in
            a|A )
                if git commit -m "$commit_message"; then
                    echo "Changes committed successfully!"
                    return 0
                else
                    echo "Commit failed. Please check your changes and try again."
                    return 1
                fi
                ;;
            e|E )
                read_input "Enter your commit message: "
                commit_message=$REPLY
                if [ -n "$commit_message" ] && git commit -m "$commit_message"; then
                    echo "Changes committed successfully with your message!"
                    return 0
                else
                    echo "Commit failed. Please check your message and try again."
                    return 1
                fi
                ;;
            r|R )
                echo "Regenerating commit message..."
                commit_message=$(generate_commit_message)
                ;;
            c|C )
                echo "Commit cancelled."
                return 1
                ;;
            * )
                echo "Invalid choice. Please try again."
                ;;
        esac
    done
}
