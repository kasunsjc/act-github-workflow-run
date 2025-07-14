# Act Command Reference

This file contains the correct `act` command flags and options.

## Common Act Flags

### Basic Usage
- `act` - Run all workflows
- `act --list` or `act -l` - List workflows
- `act --dryrun` or `act -n` - Dry run (show what would execute)
- `act --help` or `act -h` - Show help

### Workflow Selection
- `act -W <workflow-file>` - Run specific workflow file
- `act -j <job-name>` - Run specific job
- `act <event>` - Run workflows for specific event (push, pull_request, etc.)

### Configuration
- `act --env-file <file>` - Load environment variables from file
- `act --secret-file <file>` - Load secrets from file
- `act -P <platform>=<image>` - Use custom Docker image for platform
- `act --platform <platform>` - Run only jobs for specific platform

### Output & Debugging
- `act -v` or `act --verbose` - Verbose output
- `act -q` or `act --quiet` - Quiet mode
- `act --rm` - Remove containers after execution (default: true)
- `act --reuse` - Reuse containers between runs

### Advanced Options
- `act --pull` - Pull Docker images (default: true)
- `act --bind` - Bind working directory to container
- `act --artifact-server-path <path>` - Path for artifact server
- `act --container-daemon-socket <socket>` - Docker daemon socket

## Examples

```bash
# List all workflows
act --list

# Dry run all workflows
act --dryrun

# Run specific workflow
act -W .github/workflows/ci.yml

# Run with custom environment
act --env-file .env --secret-file .secrets

# Use smaller Docker image
act -P ubuntu-latest=node:16-alpine

# Verbose output for debugging
act -v

# Run specific event
act push
act pull_request
```

## Note
- The correct dry run flag is `--dryrun` (NOT `--dry-run`)
- Some older versions might use `-n` for dry run
- Always check `act --help` for the most up-to-date options
