#!/bin/bash

# Quick start script for act demo
# This script helps you get started with act quickly

set -e

echo "🚀 Act Demo Quick Start"
echo "======================="

# Check if act is installed
if ! command -v act &> /dev/null; then
    echo "❌ 'act' is not installed. Please install it first:"
    echo "   macOS: brew install act"
    echo "   Linux: curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash"
    echo "   Windows: choco install act-cli"
    exit 1
fi

# Check if Docker is running
if ! docker ps &> /dev/null; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

echo "✅ act is installed: $(act --version)"
echo "✅ Docker is running"

# Install npm dependencies
echo ""
echo "📦 Installing dependencies..."
npm install

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo ""
    echo "📝 Creating .env file..."
    cp .env.example .env
    echo "✅ Created .env file from example"
fi

# Create .secrets file if it doesn't exist
if [ ! -f .secrets ]; then
    echo ""
    echo "🔒 Creating .secrets file..."
    cp .secrets.example .secrets
    echo "✅ Created .secrets file from example"
    echo "⚠️  Please edit .secrets with your actual values"
fi

# Create .actrc file if it doesn't exist
if [ ! -f .actrc ]; then
    echo ""
    echo "⚙️  Creating .actrc file..."
    cp .actrc.example .actrc
    echo "✅ Created .actrc file from example"
fi

echo ""
echo "🎯 Ready to run act! Try these commands:"
echo ""
echo "  # List all workflows:"
echo "  act --list"
echo ""
echo "  # Run all workflows:"
echo "  act"
echo ""
echo "  # Run specific workflow:"
echo "  act -W .github/workflows/simple-ci.yml"
echo ""
echo "  # Run with verbose output:"
echo "  act -v"
echo ""
echo "  # Dry run (see what would run):"
echo "  act --dry-run"
echo ""
echo "Happy testing! 🎉"
