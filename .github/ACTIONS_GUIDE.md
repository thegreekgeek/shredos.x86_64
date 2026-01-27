# How to Run GitHub Actions on Branches Other Than Main

## Quick Answer

To run GitHub Actions on branches other than main, configure your workflow triggers to include all branches using the `'**'` pattern:

```yaml
on:
  push:
    branches:
      - '**'  # Runs on all branches
  pull_request:
    branches:
      - '**'  # Runs on PRs to all branches
```

## Solution Implemented

This repository now includes two GitHub Actions workflows that demonstrate running actions on any branch:

### 1. CI Workflow (`.github/workflows/ci.yml`)
- ✅ Runs on push to **any branch**
- ✅ Runs on pull requests to **any branch**
- ✅ Can be triggered manually via workflow_dispatch
- ✅ Validates repository structure
- ✅ Checks shell script syntax

### 2. Branch-Specific Workflow (`.github/workflows/branch-workflow.yml`)
- ✅ Runs on all branches
- ✅ Shows branch information
- ✅ Demonstrates conditional execution based on branch name
- ✅ Includes matrix build example

## How to Test

1. **Push to any branch:**
   ```bash
   git checkout -b feature/my-new-feature
   git push origin feature/my-new-feature
   ```

2. **View workflow runs:**
   - Go to the "Actions" tab on GitHub
   - You'll see workflows running for your feature branch

3. **Manual trigger:**
   - Go to Actions → Select a workflow → "Run workflow"
   - Choose any branch from the dropdown
   - Click "Run workflow"

## Key Points

- The `'**'` pattern matches all branches (including main and feature branches)
- You can use specific patterns like `'feature/**'` to match only certain branches
- Each workflow run shows which branch triggered it
- Workflows can have conditional steps that only run on specific branches

## Additional Resources

- [Full documentation](./.github/workflows/README.md)
- [GitHub Actions documentation](https://docs.github.com/en/actions)
- [Workflow syntax reference](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
