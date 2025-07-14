# GitHub Actions Local Runner (act) Demo

This repository demonstrates how to use `act` to run GitHub Actions workflows locally. The `act` tool allows you to test your GitHub Actions workflows locally without pushing to GitHub.

## Prerequisites

### 1. Install Docker
`act` uses Docker to run workflows, so Docker must be installed and running on your system.

**macOS:**
```bash
# Install Docker Desktop
brew install --cask docker
# Or download from https://docker.com/products/docker-desktop
```

**Linux:**
```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install docker.io
sudo systemctl start docker
sudo systemctl enable docker

# Add your user to docker group
sudo usermod -aG docker $USER
# Log out and back in for group changes to take effect
```

**Windows:**
- Download and install Docker Desktop from https://docker.com/products/docker-desktop

### 2. Install act

**macOS:**
```bash
# Using Homebrew
brew install act

# Using curl
curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash
```

**Linux:**
```bash
# Using curl
curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash

# Or download from GitHub releases
# https://github.com/nektos/act/releases
```

**Windows:**
```bash
# Using Chocolatey
choco install act-cli

# Using Scoop
scoop install act

# Or download from GitHub releases
```

### 3. Verify Installation

```bash
# Check act version
act --version

# Check Docker is running
docker --version
docker ps
```

## Demo Workflows

This demo includes several workflows to showcase different `act` capabilities:

1. **Simple CI Workflow** (`.github/workflows/simple-ci.yml`) - Basic build and test
2. **Multi-OS Workflow** (`.github/workflows/multi-os.yml`) - Testing across different operating systems
3. **Environment Variables** (`.github/workflows/env-vars.yml`) - Working with secrets and environment variables
4. **Artifacts Demo** (`.github/workflows/artifacts.yml`) - Uploading and downloading artifacts
5. **Matrix Strategy** (`.github/workflows/matrix.yml`) - Matrix builds with different versions

## Quick Start

### 1. Clone and Navigate
```bash
git clone <this-repo>
cd act-demo
```

### 2. Run All Workflows
```bash
# List all workflows
act --list

# Run all workflows
act

# Run specific workflow
act -W .github/workflows/simple-ci.yml

# Run specific job
act -j build
```

### 3. Common act Commands

```bash
# Dry run (don't actually run, just show what would run)
act --dryrun

# Run with specific event
act push
act pull_request

# Use different Docker image sizes
act -P ubuntu-latest=node:16-buster-slim  # Small image
act -P ubuntu-latest=catthehacker/ubuntu:act-latest  # Medium image (default)

# Run with secrets
act --secret-file .secrets

# Run with environment variables
act --env-file .env

# Verbose output
act -v

# Run specific workflow file
act -W .github/workflows/simple-ci.yml

# Run specific job
act -j test

# List all workflows and jobs
act -l
```

### 4. Working with Secrets

Create a `.secrets` file (don't commit this to git):
```bash
# .secrets
GITHUB_TOKEN=your_github_token_here
API_KEY=your_api_key_here
```

Then run:
```bash
act --secret-file .secrets
```

### 5. Working with Environment Variables

Create a `.env` file:
```bash
# .env
NODE_ENV=development
DEBUG=true
```

Then run:
```bash
act --env-file .env
```

## Troubleshooting

### Common Issues

1. **Docker not running**
   ```bash
   # Make sure Docker is running
   docker ps
   ```

2. **Permission denied (Linux)**
   ```bash
   # Add user to docker group
   sudo usermod -aG docker $USER
   # Then log out and back in
   ```

3. **Large Docker images**
   ```bash
   # Use smaller images for faster execution
   act -P ubuntu-latest=node:16-alpine
   ```

4. **Workflow not found**
   ```bash
   # Make sure you're in the repository root
   # Check workflow files exist in .github/workflows/
   ls -la .github/workflows/
   ```

### Performance Tips

1. **Use smaller Docker images:**
   ```bash
   act -P ubuntu-latest=node:16-alpine
   ```

2. **Cache Docker images:**
   ```bash
   # Pull images beforehand
   docker pull catthehacker/ubuntu:act-latest
   ```

3. **Use act configuration file:**
   Create `.actrc` file:
   ```
   -P ubuntu-latest=catthehacker/ubuntu:act-latest
   --secret-file .secrets
   --env-file .env
   ```

## Advanced Usage

### Custom Platform Images
```bash
# Create .actrc file with custom images
echo "-P ubuntu-latest=catthehacker/ubuntu:act-latest" > .actrc
echo "-P ubuntu-20.04=catthehacker/ubuntu:act-20.04" >> .actrc
```

### Running Specific Events
```bash
# Simulate different GitHub events
act push
act pull_request
act schedule
act workflow_dispatch
```

### Debugging Workflows
```bash
# Run with shell access for debugging
act -s

# Run with verbose logging
act -v

# Dry run to see what would execute
act --dryrun
```

## Files in This Demo

- `README.md` - This documentation
- `.github/workflows/` - GitHub Actions workflow files
- `src/` - Sample application code
- `package.json` - Node.js dependencies
- `.gitignore` - Git ignore patterns
- `.actrc` - act configuration (optional)

## Resources

- [act GitHub Repository](https://github.com/nektos/act)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docker Images for act](https://github.com/catthehacker/docker_images)
- [act Configuration](https://github.com/nektos/act#configuration)

## Contributing

Feel free to add more workflow examples or improve the documentation!

## License

MIT License - see LICENSE file for details.
