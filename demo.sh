#!/bin/bash

# Act Demo Script
# This script demonstrates various act commands and features

set -e

BOLD='\033[1m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

print_header() {
    echo -e "\n${BLUE}${BOLD}$1${NC}"
    echo -e "${BLUE}$(echo "$1" | sed 's/./=/g')${NC}"
}

print_command() {
    echo -e "\n${YELLOW}$ $1${NC}"
}

wait_for_user() {
    echo -e "\n${GREEN}Press Enter to continue...${NC}"
    read
}

# Check prerequisites
print_header "🔍 Checking Prerequisites"

if ! command -v act &> /dev/null; then
    echo -e "${RED}❌ 'act' is not installed${NC}"
    exit 1
fi

if ! docker ps &> /dev/null; then
    echo -e "${RED}❌ Docker is not running${NC}"
    exit 1
fi

echo -e "${GREEN}✅ act is installed: $(act --version)${NC}"
echo -e "${GREEN}✅ Docker is running${NC}"

# Install dependencies
print_header "📦 Installing Dependencies"
print_command "npm install"
npm install

print_header "🎯 Act Demo - GitHub Actions Local Runner"
echo "This demo will show you how to use act to run GitHub Actions workflows locally."
echo ""
echo "Note: If you encounter authentication errors with GitHub actions,"
echo "run './setup-github-auth.sh' to configure a GitHub token."

wait_for_user

# 1. List workflows
print_header "1. Listing Available Workflows"
print_command "act --list"
act --list

wait_for_user

# 2. Dry run
print_header "2. Dry Run (See What Would Execute)"
print_command "act --dryrun"
act --dryrun

wait_for_user

# 3. Run a specific simple workflow
print_header "3. Running the Act Test Workflow"
print_command "act -W .github/workflows/act-test.yml"
act -W .github/workflows/act-test.yml

wait_for_user

# 4. Run with environment variables
print_header "4. Running with Environment Variables"
print_command "act -W .github/workflows/env-vars.yml --env-file .env"
if [ -f .env ]; then
    act -W .github/workflows/env-vars.yml --env-file .env
else
    echo "Creating .env file first..."
    cp .env.example .env
    act -W .github/workflows/env-vars.yml --env-file .env
fi

wait_for_user

# 5. Run with secrets
print_header "5. Running with Secrets"
print_command "act -W .github/workflows/env-vars.yml --secret-file .secrets"
if [ -f .secrets ]; then
    act -W .github/workflows/env-vars.yml --secret-file .secrets
else
    echo "Creating .secrets file first..."
    cp .secrets.example .secrets
    echo "Note: Using example secrets. In real usage, add actual secret values."
    act -W .github/workflows/env-vars.yml --secret-file .secrets
fi

wait_for_user

# 6. Run simple CI workflow (act-compatible)
print_header "6. Running Simple CI Workflow (Act Compatible)"
print_command "act -W .github/workflows/simple-ci-no-actions.yml"
act -W .github/workflows/simple-ci-no-actions.yml

wait_for_user

# 6b. Run artifacts demo (act-compatible)
print_header "6b. Running Artifacts Demo (Act Compatible)"
print_command "act -W .github/workflows/artifacts-act-compatible.yml"
echo "This demonstrates artifact-like functionality using local files and tar archives:"
act -W .github/workflows/artifacts-act-compatible.yml

wait_for_user

# 7. Show verbose output
print_header "7. Running with Verbose Output"
print_command "act -W .github/workflows/act-test.yml -v"
echo "Note: This will show detailed output. Press Ctrl+C if it takes too long."
act -W .github/workflows/act-test.yml -v

wait_for_user

# 8. Run specific job
print_header "8. Running Specific Job"
print_command "act -j hello-act"
act -j hello-act

wait_for_user

# 9. Run with different event
print_header "9. Running with Different Events"
print_command "act push"
act push

wait_for_user

print_command "act pull_request"
act pull_request

wait_for_user

# 10. Using different Docker images
print_header "10. Using Different Docker Images"
print_command "act -P ubuntu-latest=node:18-alpine -W .github/workflows/simple-ci.yml"
echo "This uses a smaller Alpine-based image for faster execution:"
act -P ubuntu-latest=node:18-alpine -W .github/workflows/simple-ci.yml

print_header "🎉 Act Demo Complete!"
echo -e "${GREEN}You've successfully run various act commands!${NC}"
echo ""
echo "Key takeaways:"
echo "• act --list: List all workflows"
echo "• act --dryrun: See what would run without actually running"
echo "• act -W <file>: Run specific workflow file"
echo "• act -j <job>: Run specific job"
echo "• act -v: Verbose output for debugging"
echo "• act --env-file: Load environment variables"
echo "• act --secret-file: Load secrets"
echo "• act -P: Use custom Docker images"
echo ""
echo -e "${BLUE}For more information, check the README.md file!${NC}"
