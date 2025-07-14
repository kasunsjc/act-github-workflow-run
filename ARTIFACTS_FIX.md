# 🚨 ARTIFACTS ERROR SOLUTION

## The Error You Encountered

```
❗ ::error::Unable to get the ACTIONS_RUNTIME_TOKEN env variable
```

This happens when trying to use GitHub Actions artifacts (`actions/upload-artifact@v4`) with `act`.

## ✅ Quick Fix

Use these act-compatible workflows instead:

### Instead of `artifacts.yml` (fails with act):
```bash
❌ act -W .github/workflows/artifacts.yml
```

### Use these (work with act):
```bash
✅ act -W .github/workflows/artifacts-act-compatible.yml
✅ act -W .github/workflows/artifacts-hybrid.yml
✅ act -W .github/workflows/simple-ci-no-actions.yml
```

## 🔧 What's Different

### GitHub Actions (doesn't work with act):
```yaml
- name: Upload artifacts
  uses: actions/upload-artifact@v4
  with:
    name: build-files
    path: dist/
```

### Act-Compatible Alternative:
```yaml
- name: Package artifacts
  run: |
    mkdir -p artifacts
    tar -czf artifacts/build-files.tar.gz -C dist .
    echo "✅ Artifacts packaged locally"
```

## 📋 Act-Compatible Workflows in This Demo

| Workflow | Works with act? | Purpose |
|----------|----------------|---------|
| `act-test.yml` | ✅ Yes | Basic act testing |
| `simple-ci-no-actions.yml` | ✅ Yes | CI without external actions |
| `artifacts-act-compatible.yml` | ✅ Yes | File-based artifacts |
| `artifacts-hybrid.yml` | ✅ Yes | Works with both act & GitHub |
| `env-vars.yml` | ✅ Yes | Environment variables demo |
| `simple-ci.yml` | ❌ No | Uses actions/checkout & setup-node |
| `artifacts.yml` | ❌ No | Uses actions/upload-artifact |
| `multi-os.yml` | ❌ No | Matrix builds (GitHub only) |

## 🎯 Recommended Testing Flow

1. **Local Development** (use act):
   ```bash
   act -W .github/workflows/artifacts-act-compatible.yml
   ```

2. **Push to GitHub** (test full features):
   ```bash
   git push origin main
   # GitHub Actions will run artifacts.yml with real artifacts
   ```

3. **Best of Both** (hybrid approach):
   ```bash
   act -W .github/workflows/artifacts-hybrid.yml
   # Uses file-based artifacts locally, real artifacts on GitHub
   ```

## 🚀 Quick Test

```bash
# This will work perfectly with act:
act -W .github/workflows/artifacts-act-compatible.yml

# See all available workflows:
act --list
```

For more details, see `ARTIFACTS_GUIDE.md`.
