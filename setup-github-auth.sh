#!/bin/bash

# GitHub Token Setup Script for act
# This script helps you configure GitHub authentication for act

set -e

BOLD='\033[1m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}${BOLD}🔧 GitHub Token Setup for act${NC}"
echo -e "${BLUE}================================${NC}"
echo ""

echo -e "${YELLOW}📝 To fix the authentication error, you need a GitHub Personal Access Token.${NC}"
echo ""

echo -e "${BOLD}Step 1: Create a GitHub Token${NC}"
echo "1. Go to: https://github.com/settings/tokens"
echo "2. Click 'Generate new token (classic)'"
echo "3. Give it a name like 'act-local-runner'"
echo "4. Select expiration (30 days recommended for testing)"
echo "5. Select scopes:"
echo "   ✅ public_repo (minimum required)"
echo "   ✅ repo (if you have private repos)"
echo "6. Click 'Generate token'"
echo "7. Copy the token (you won't see it again!)"
echo ""

echo -e "${BOLD}Step 2: Configure act${NC}"
echo ""

# Check if .secrets file exists
if [ -f .secrets ]; then
    echo -e "${GREEN}✅ .secrets file already exists${NC}"
    if grep -q "GITHUB_TOKEN=" .secrets; then
        echo -e "${GREEN}✅ GITHUB_TOKEN is already configured in .secrets${NC}"
        echo ""
        echo -e "${YELLOW}If you're still getting authentication errors, make sure your token is valid.${NC}"
    else
        echo -e "${YELLOW}⚠️  GITHUB_TOKEN not found in .secrets file${NC}"
        echo ""
        echo "Add your token to .secrets file:"
        echo "GITHUB_TOKEN=your_token_here"
    fi
else
    echo "Creating .secrets file from template..."
    cp .secrets.example .secrets
    echo -e "${GREEN}✅ Created .secrets file${NC}"
    echo ""
    echo -e "${YELLOW}📝 Edit .secrets file and replace 'ghp_your_github_token_here' with your actual token${NC}"
fi

echo ""
echo -e "${BOLD}Step 3: Test act with authentication${NC}"
echo ""
echo "Run one of these commands:"
echo ""
echo "# Test with the simple workflow (no external actions needed):"
echo -e "${GREEN}act -W .github/workflows/simple-ci-no-actions.yml${NC}"
echo ""
echo "# Test with the original workflow (requires GitHub token):"
echo -e "${GREEN}act -W .github/workflows/simple-ci.yml --secret-file .secrets${NC}"
echo ""
echo "# Or use act with inline token:"
echo -e "${GREEN}act -s GITHUB_TOKEN=your_token_here -W .github/workflows/simple-ci.yml${NC}"
echo ""

echo -e "${BOLD}Alternative: Use workflows without external actions${NC}"
echo "The workflow 'simple-ci-no-actions.yml' doesn't require external GitHub actions"
echo "and will work without authentication issues."
echo ""

echo -e "${BLUE}🎯 Quick test command:${NC}"
echo -e "${GREEN}act --list${NC}"
echo ""

echo -e "${GREEN}Happy testing! 🎉${NC}"
