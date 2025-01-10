# Create a function to generate AI-powered PR messages using LLM with the Github CLI
#
#  Requires: 
#  - Github CLI (gh) installed and authenticated
#  - LLM installed and configured with your desired model <https://llm.datasette.io/en/stable/>
#

# -----------------------------------------------------------------------------
LLM_MODEL="chatsbp/azure/gpt-4o"                      # Replace with your desired model

# AWS_PROFILE=bedrockai llm -m $LLM_MODEL "Hello, world!"  # Test the model
# -----------------------------------------------------------------------------


github-pr() {
    # Ensure you are on a feature branch and not main branch
    if [[ "$(git rev-parse --abbrev-ref HEAD)" == "main" ]]; then
        echo "You are on the main branch. Switch to a feature branch to create a PR."
        return 1
    fi
    
    # Check if there is a difference with the main branch
    if [ -z "$(git diff --name-only origin/main)" ]; then
        echo "No differences found with the main branch. Nothing to PR."
        return 1
    fi

    # Generate the PR message using AI
    generate_pr_message() {
        git diff origin/main | llm -m $LLM_MODEL "
Below is a diff of all changes compared to the main branch, coming from the command:
\`\`\`
git diff origin/main
\`\`\`
Please generate a concise pull request message for these changes."
    }

    read_input() {
        if [ -n "$ZSH_VERSION" ]; then
            echo -n "$1"
            read -r REPLY
        else
            read -p "$1" -r REPLY
        fi
    }
    
    # Main script
    echo "Generating AI-powered PR message..."
    pr_message=$(generate_pr_message)
    while true; do
        echo -e "\nProposed PR message:"
        echo "$pr_message"
        read_input "Do you want to (a)ccept, (e)dit, (r)egenerate, or (c)ancel? "
        choice=$REPLY
        case "$choice" in
            a|A )
                current_branch=$(git rev-parse --abbrev-ref HEAD)
                if gh pr create --base main --head "$current_branch" --title "$(echo "$pr_message" | head -n 1)" --body "$(echo "$pr_message")"; then
                    echo "PR created successfully!"
                    return 0
                else
                    echo "PR creation failed. Please check your changes and try again."
                    return 1
                fi
                ;;
            e|E )
                read_input "Enter your PR message: "
                pr_message=$REPLY
                current_branch=$(git rev-parse --abbrev-ref HEAD)
                if [ -n "$pr_message" ] && gh pr create --base main --head "$current_branch" --title "$(echo "$pr_message" | head -n 1)" --body "$(echo "$pr_message")"; then
                    echo "PR created successfully with your message!"
                    return 0
                else
                    echo "PR creation failed. Please check your message and try again."
                    return 1
                fi
                ;;
            r|R )
                echo "Regenerating PR message..."
                pr_message=$(generate_pr_message)
                ;;
            c|C )
                echo "PR creation cancelled."
                return 1
                ;;
            * )
                echo "Invalid choice. Please try again."
                ;;
        esac
    done
}