# Makefile for Act Demo
# Use this to run common act commands easily

.PHONY: help install setup demo clean list run test

# Default target
help:
	@echo "Act Demo - Available commands:"
	@echo "  make install    - Install dependencies"
	@echo "  make setup      - Setup configuration files" 
	@echo "  make list       - List all workflows"
	@echo "  make run        - Run all workflows"
	@echo "  make test       - Run test workflow"
	@echo "  make ci         - Run CI workflow"
	@echo "  make demo       - Run interactive demo"
	@echo "  make clean      - Clean up generated files"
	@echo "  make dry-run    - Show what would run"

# Install npm dependencies
install:
	npm install

# Setup configuration files
setup:
	@echo "Setting up configuration files..."
	@[ -f .env ] || cp .env.example .env
	@[ -f .secrets ] || cp .secrets.example .secrets
	@[ -f .actrc ] || cp .actrc.example .actrc
	@echo "✅ Configuration files ready"

# List all workflows
list:
	act --list

# Run all workflows  
run:
	act

# Run specific test workflow
test:
	act -W .github/workflows/act-test.yml

# Run CI workflow
ci:
	act -W .github/workflows/simple-ci.yml

# Run interactive demo
demo:
	./demo.sh

# Dry run to see what would execute
dry-run:
	act --dryrun

# Clean up generated files
clean:
	rm -rf node_modules/
	rm -rf dist/
	rm -rf reports/
	rm -f .env .secrets .actrc
	@echo "✅ Cleaned up generated files"

# Quick start
quickstart:
	./quickstart.sh
