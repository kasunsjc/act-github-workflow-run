#!/bin/bash

# Gitignore Security Verification Script
# This script helps verify that sensitive files are properly ignored

set -e

BOLD='\033[1m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}${BOLD}🔒 Security Gitignore Verification${NC}"
echo -e "${BLUE}===================================${NC}"
echo ""

# Function to check if file is ignored
check_ignored() {
    local file=$1
    if git check-ignore "$file" >/dev/null 2>&1; then
        echo -e "${GREEN}✅ $file${NC} - properly ignored"
        return 0
    else
        echo -e "${RED}❌ $file${NC} - NOT ignored (potential security risk!)"
        return 1
    fi
}

# Function to test file patterns
test_pattern() {
    local pattern=$1
    local test_file=$2
    
    echo "Testing pattern: $pattern"
    
    # Create temporary test file
    touch "$test_file"
    
    if check_ignored "$test_file"; then
        rm -f "$test_file"
        return 0
    else
        rm -f "$test_file"
        return 1
    fi
}

echo -e "${BOLD}Testing essential security patterns:${NC}"
echo ""

failed_tests=0

# Test environment files
echo -e "${YELLOW}Environment Variables:${NC}"
test_pattern ".env files" ".env" || ((failed_tests++))
test_pattern ".env.local files" ".env.local" || ((failed_tests++))
test_pattern ".secrets files" ".secrets" || ((failed_tests++))

echo ""

# Test certificate files
echo -e "${YELLOW}Certificates and Keys:${NC}"
test_pattern "*.key files" "test.key" || ((failed_tests++))
test_pattern "*.pem files" "test.pem" || ((failed_tests++))
test_pattern "service account files" "service-account.json" || ((failed_tests++))

echo ""

# Test config files
echo -e "${YELLOW}Configuration Files:${NC}"
test_pattern "config.json" "config.json" || ((failed_tests++))
test_pattern "local.settings.json" "local.settings.json" || ((failed_tests++))

echo ""

# Test database files
echo -e "${YELLOW}Database Files:${NC}"
test_pattern "*.db files" "test.db" || ((failed_tests++))
test_pattern "*.sqlite files" "test.sqlite" || ((failed_tests++))

echo ""

# Test pattern-based files
echo -e "${YELLOW}Pattern-based Files:${NC}"
test_pattern "secret files" "my-secret.txt" || ((failed_tests++))
test_pattern "password files" "passwords.txt" || ((failed_tests++))
test_pattern "private files" "private-key.txt" || ((failed_tests++))

echo ""

# Check that example files are NOT ignored
echo -e "${YELLOW}Example Files (should NOT be ignored):${NC}"
if git check-ignore ".env.example" >/dev/null 2>&1; then
    echo -e "${RED}❌ .env.example${NC} - should NOT be ignored"
    ((failed_tests++))
else
    echo -e "${GREEN}✅ .env.example${NC} - correctly not ignored"
fi

if git check-ignore ".secrets.example" >/dev/null 2>&1; then
    echo -e "${RED}❌ .secrets.example${NC} - should NOT be ignored"
    ((failed_tests++))
else
    echo -e "${GREEN}✅ .secrets.example${NC} - correctly not ignored"
fi

echo ""

# Check for any staged sensitive files
echo -e "${BOLD}Checking staged files for potential secrets:${NC}"
staged_files=$(git diff --staged --name-only 2>/dev/null || echo "")

if [ -z "$staged_files" ]; then
    echo -e "${GREEN}✅ No files currently staged${NC}"
else
    echo "Staged files:"
    echo "$staged_files"
    
    # Check each staged file for potential secrets
    secret_found=false
    while IFS= read -r file; do
        if [[ -f "$file" ]]; then
            # Simple pattern check
            if grep -l -i "password\|secret\|key\|token\|credential" "$file" >/dev/null 2>&1; then
                echo -e "${RED}⚠️  Potential secret found in: $file${NC}"
                secret_found=true
            fi
        fi
    done <<< "$staged_files"
    
    if [ "$secret_found" = false ]; then
        echo -e "${GREEN}✅ No obvious secrets found in staged files${NC}"
    fi
fi

echo ""

# Summary
if [ $failed_tests -eq 0 ]; then
    echo -e "${GREEN}${BOLD}🎉 All security tests passed!${NC}"
    echo -e "${GREEN}Your .gitignore is properly configured to protect sensitive files.${NC}"
else
    echo -e "${RED}${BOLD}⚠️  $failed_tests security test(s) failed!${NC}"
    echo -e "${RED}Your .gitignore may not be protecting all sensitive files.${NC}"
    echo -e "${YELLOW}Please review the .gitignore file and fix any issues.${NC}"
fi

echo ""
echo -e "${BLUE}Additional security commands:${NC}"
echo "  git status --ignored    # See all ignored files"
echo "  git check-ignore <file> # Test if specific file is ignored"
echo "  ./verify-gitignore.sh   # Run this script again"

exit $failed_tests
