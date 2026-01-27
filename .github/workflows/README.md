# GitHub Actions Workflows

This directory contains GitHub Actions workflows that run automated checks on the ShredOS repository.

## Running Actions on Different Branches

By default, GitHub Actions workflows only run on the `main` branch, but we've configured these workflows to run on **all branches**. This is useful for:

- Testing feature branches before merging
- Running CI checks on pull requests
- Validating changes on development branches

## Available Workflows

### 1. CI Workflow (`ci.yml`)

**Triggers:**
- On push to any branch (using `branches: ['**']`)
- On pull requests to any branch
- Manual trigger via workflow_dispatch

**Jobs:**
- `validate`: Checks repository structure and required files
- `syntax-check`: Validates shell script syntax

### 2. Branch-Specific Workflow (`branch-workflow.yml`)

**Triggers:**
- On push to any branch
- On pull requests to any branch

**Features:**
- Displays detailed branch information
- Conditional job execution based on branch name
- Matrix build example

## Configuring Branch Triggers

### Run on All Branches
```yaml
on:
  push:
    branches:
      - '**'  # Matches all branches
```

### Run on Specific Branches
```yaml
on:
  push:
    branches:
      - main
      - develop
      - 'feature/**'  # All branches starting with feature/
      - 'release/**'  # All branches starting with release/
```

### Run on All Except Specific Branches
```yaml
on:
  push:
    branches:
      - '**'
    branches-ignore:
      - 'temp/**'
      - 'wip/**'
```

### Run on Pull Requests
```yaml
on:
  pull_request:
    branches:
      - main  # PRs targeting main branch
      - '**'  # PRs targeting any branch
```

## Manual Workflow Triggers

All workflows support manual triggering via the Actions tab on GitHub:

1. Go to the "Actions" tab in your repository
2. Select the workflow you want to run
3. Click "Run workflow"
4. Select the branch to run on
5. Click "Run workflow" button

## Conditional Execution

You can run specific steps only on certain branches:

```yaml
- name: Run on feature branches only
  if: startsWith(github.ref, 'refs/heads/feature/')
  run: echo "This is a feature branch"

- name: Run on main branch only
  if: github.ref == 'refs/heads/main'
  run: echo "This is the main branch"
```

## Common Branch Patterns

- `main` or `master` - Main production branch
- `develop` - Development branch
- `feature/*` - Feature branches (e.g., `feature/new-nwipe-version`)
- `release/*` - Release branches (e.g., `release/v2024.11`)
- `hotfix/*` - Hotfix branches (e.g., `hotfix/critical-bug`)
- `copilot/*` - Copilot/AI-assisted branches

## Environment Variables

Available in all workflows:

- `GITHUB_REF` - Full git ref (e.g., `refs/heads/feature/my-branch`)
- `GITHUB_SHA` - Commit SHA that triggered the workflow
- `GITHUB_ACTOR` - Username of person/bot that triggered the workflow
- `GITHUB_REPOSITORY` - Repository name (e.g., `thegreekgeek/shredos.x86_64`)
- `GITHUB_EVENT_NAME` - Name of webhook event (e.g., `push`, `pull_request`)

## Examples

### Example 1: Run on all branches except temporary ones
```yaml
on:
  push:
    branches:
      - '**'
    branches-ignore:
      - 'tmp/**'
      - 'experimental/**'
```

### Example 2: Different jobs for different branches
```yaml
jobs:
  build-production:
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - run: echo "Building production release"
  
  build-development:
    if: github.ref != 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - run: echo "Building development version"
```

## Testing Workflows

To test these workflows:

1. Create a new branch: `git checkout -b feature/test-actions`
2. Make a change and push: `git push origin feature/test-actions`
3. Go to the Actions tab on GitHub to see the workflow run
4. Check the logs to verify it's running on your feature branch

## Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Workflow Syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- [Events that trigger workflows](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows)
