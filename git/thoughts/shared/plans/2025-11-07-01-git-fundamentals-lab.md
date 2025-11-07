# Git Fundamentals Lab Implementation Plan

## Overview

This plan details the implementation of **Lab 1: Git Fundamentals**, the first in a 3-lab series teaching Git using Instruqt's new HCL format. This lab teaches beginner-level Git concepts through hands-on exercises in a pre-configured environment with bare repositories simulating real remote workflows, without requiring GitHub authentication.

**Target Audience:** Developers new to Git or those seeking foundational understanding
**Duration:** 60-90 minutes
**Format:** Interactive Instruqt lab with terminal access and automated validation

## Current State Analysis

### What Exists Now

**Directory Structure:**
- `/Users/erik/code/instruqt/labs/git/` exists with only research documentation
- No HCL configuration files exist yet
- No lab structure has been created

**Available Resources:**
- Research document: `thoughts/shared/research/2025-11-07-01-instruqt-git-lab-design.md`
- Beej's Git Guide as content source: 32 chapters covering beginner through advanced
- Instruqt HCL examples in `/Users/erik/code/instruqt/lab-examples/`
- New HCL format patterns documented and understood

### Key Discoveries from Research

**From**: `thoughts/shared/research/2025-11-07-01-instruqt-git-lab-design.md`

1. **Bare Repository Pattern** (lines 393-423): Pre-configured bare repos in `/opt/git/` allow students to interact with remotes without authentication overhead
2. **HCL File Structure** (lines 39-67): Labs use separate config files (`main.hcl`, `sandbox.hcl`, `pages.hcl`, `layouts.hcl`, `tasks.hcl`, `tabs.hcl`)
3. **Task Validation Pattern** (lines 140-161, 432-448): Shell scripts validate Git state and provide contextual failure messages
4. **Content Adaptation** (lines 168-194): Beej's Chapters 2-6 map to fundamental topics: init, commits, branches, merging, basic remotes
5. **Container Setup** (lines 375-390): Ubuntu container with Git pre-installed via startup command
6. **Three-Lab Series** (lines 323-350): This is Lab 1 of 3, with clear progression to intermediate and advanced topics

### Constraints

1. **No GitHub Integration**: Focus on pure Git mechanics, avoid platform-specific features
2. **Beginner Focus**: Assume no prior Git knowledge
3. **Offline Capable**: All operations happen within sandbox, no external dependencies
4. **HCL Format**: Must use new format (not old module-based format in getting-started lab)
5. **Duration Limit**: 60-90 minutes means ~8-10 exercises maximum

## Desired End State

### Specification

Students will complete a fully functional Git Fundamentals lab where they:

1. **Configure Git identity** and understand basic Git concepts
2. **Initialize repositories** and understand the `.git` directory
3. **Stage and commit changes** following the modify → stage → commit workflow
4. **Navigate commit history** using `git log` and relative commit notation
5. **Work with branches** including creation, switching, and fast-forward merges
6. **Resolve merge conflicts** in a guided, safe environment
7. **Clone from remotes** and understand the origin concept
8. **Push and pull changes** to/from pre-configured bare repositories
9. **Explore detached HEAD** safely and understand recovery

### Verification

**Automated:**
- All task validation scripts pass
- `instruqt lab validate` reports no errors
- Container starts successfully with Git installed

**Manual:**
- Lab loads in Instruqt platform
- All instruction pages render correctly
- Terminal is functional and responsive
- Tasks validate correctly when completed
- Failure messages are helpful and actionable
- Success messages provide positive feedback

## What We're NOT Doing

To prevent scope creep, this lab explicitly **excludes**:

1. **GitHub-specific features**: No forking, pull requests, GitHub CLI, SSH key setup, or authentication
2. **Advanced operations**: No reset, reflog, rebase, stash, cherry-pick (those are Labs 2 & 3)
3. **Submodules**: Too advanced for fundamentals
4. **Git hooks**: Out of scope for beginner lab
5. **Git LFS**: Not part of core fundamentals
6. **Interactive rebase**: Covered in Lab 2
7. **Multiple remotes**: Only single `origin` remote in this lab
8. **Worktrees**: Advanced topic for Lab 3
9. **Bare repository explanation**: Students just use `origin` without needing to understand infrastructure

## Implementation Approach

### Strategy

**Incremental Complexity:** Start with local operations (init, commit) before introducing remotes and branching.

**Pre-configured Environment:** Students begin with Git identity configured and bare repositories already set up, so they can focus on learning commands rather than infrastructure.

**Progressive Validation:** Early chapters have detailed guidance and hints. Later chapters expect more independence.

**Scenario-Based Learning:** Each chapter introduces concepts through realistic scenarios (e.g., "You need to fix a bug on a separate branch").

### Chapter Structure (8 Chapters)

Based on Beej's Chapters 2-6, adapted for Instruqt:

1. **Git Basics** - What is Git, repository concepts, configuration
2. **First Repository** - `git init`, making commits, viewing history
3. **Working with Files** - Stage/unstage, commit workflow, `.gitignore`
4. **Understanding History** - `git log`, commit navigation, HEAD, detached HEAD
5. **Branching Basics** - Create/switch branches, fast-forward merges
6. **Merge Conflicts** - Understanding conflicts, resolution workflow
7. **Working with Remotes** - `git clone`, `git push`, `git pull`, origin concept
8. **Collaboration Basics** - Simulating multi-developer workflow with pre-configured remotes

## Phase 1: Project Structure and Core Configuration

### Overview
Set up the lab directory structure and create core HCL configuration files for the Git Fundamentals lab.

### Changes Required

#### 1. Directory Structure
**Location**: `/Users/erik/code/instruqt/labs/git/`

Create the following structure:
```
git-fundamentals/
├── main.hcl                    # Lab resource definition
├── sandbox.hcl                 # Infrastructure (container, network)
├── layouts.hcl                 # UI layouts
├── pages.hcl                   # Page resources
├── tasks.hcl                   # Task validation
├── tabs.hcl                    # Terminal configuration
├── description.md              # Lab description
├── instructions/               # Markdown instruction files
│   ├── 01_git_basics/
│   │   ├── what_is_git.md
│   │   └── configuration.md
│   ├── 02_first_repository/
│   │   ├── init.md
│   │   ├── first_commit.md
│   │   └── viewing_history.md
│   ├── 03_working_with_files/
│   │   ├── staging.md
│   │   ├── commit_workflow.md
│   │   └── gitignore.md
│   ├── 04_understanding_history/
│   │   ├── git_log.md
│   │   ├── commit_navigation.md
│   │   └── detached_head.md
│   ├── 05_branching_basics/
│   │   ├── creating_branches.md
│   │   ├── switching_branches.md
│   │   └── fast_forward_merge.md
│   ├── 06_merge_conflicts/
│   │   ├── understanding_conflicts.md
│   │   └── resolving_conflicts.md
│   ├── 07_working_with_remotes/
│   │   ├── cloning.md
│   │   ├── pushing.md
│   │   └── pulling.md
│   └── 08_collaboration_basics/
│       ├── multi_developer.md
│       └── conclusion.md
├── scripts/                    # Validation scripts
│   ├── setup/
│   │   ├── container_startup.sh
│   │   └── setup_bare_repos.sh
│   ├── git_configured/
│   │   └── check.sh
│   ├── repo_initialized/
│   │   └── check.sh
│   ├── first_commit/
│   │   ├── check.sh
│   │   └── solve.sh
│   ├── staged_files/
│   │   └── check.sh
│   ├── gitignore_working/
│   │   └── check.sh
│   ├── branch_created/
│   │   └── check.sh
│   ├── branch_merged/
│   │   └── check.sh
│   ├── conflict_resolved/
│   │   └── check.sh
│   ├── remote_cloned/
│   │   └── check.sh
│   ├── changes_pushed/
│   │   └── check.sh
│   └── changes_pulled/
│       └── check.sh
└── assets/                     # Images and diagrams (optional)
```

**Commands:**
```bash
cd /Users/erik/code/instruqt/labs/git
mkdir -p git-fundamentals/{instructions,scripts,assets}
mkdir -p git-fundamentals/instructions/{01_git_basics,02_first_repository,03_working_with_files,04_understanding_history,05_branching_basics,06_merge_conflicts,07_working_with_remotes,08_collaboration_basics}
mkdir -p git-fundamentals/scripts/{setup,git_configured,repo_initialized,first_commit,staged_files,gitignore_working,branch_created,branch_merged,conflict_resolved,remote_cloned,changes_pushed,changes_pulled}
```

#### 2. Main Lab Configuration
**File**: `git-fundamentals/main.hcl`

```hcl
resource "lab" "git_fundamentals" {
  title = "Git Fundamentals"
  description = file("description.md")
  tags = ["git", "version-control", "beginner", "fundamentals"]

  settings {
    theme = "modern_dark"

    timelimit {
      duration = 90
      extend = 15
      show_timer = true
    }

    idle {
      enabled = true
      timeout = 30
      show_warning = true
    }

    controls {
      show_stop = true
    }
  }

  layout = resource.layout.terminal_instructions

  content {
    chapter "git_basics" {
      title = "Git Basics"

      page "what_is_git" {
        title = "What is Git?"
        reference = resource.page.what_is_git
      }

      page "configuration" {
        title = "Configuration"
        reference = resource.page.configuration
      }
    }

    chapter "first_repository" {
      title = "Your First Repository"

      page "init" {
        title = "Initializing a Repository"
        reference = resource.page.init
      }

      page "first_commit" {
        title = "Making Your First Commit"
        reference = resource.page.first_commit
      }

      page "viewing_history" {
        title = "Viewing Commit History"
        reference = resource.page.viewing_history
      }
    }

    chapter "working_with_files" {
      title = "Working with Files"

      page "staging" {
        title = "Staging Changes"
        reference = resource.page.staging
      }

      page "commit_workflow" {
        title = "The Commit Workflow"
        reference = resource.page.commit_workflow
      }

      page "gitignore" {
        title = "Ignoring Files"
        reference = resource.page.gitignore
      }
    }

    chapter "understanding_history" {
      title = "Understanding History"

      page "git_log" {
        title = "Exploring Git Log"
        reference = resource.page.git_log
      }

      page "commit_navigation" {
        title = "Navigating Commits"
        reference = resource.page.commit_navigation
      }

      page "detached_head" {
        title = "Detached HEAD State"
        reference = resource.page.detached_head
      }
    }

    chapter "branching_basics" {
      title = "Branching Basics"

      page "creating_branches" {
        title = "Creating Branches"
        reference = resource.page.creating_branches
      }

      page "switching_branches" {
        title = "Switching Branches"
        reference = resource.page.switching_branches
      }

      page "fast_forward_merge" {
        title = "Fast-Forward Merges"
        reference = resource.page.fast_forward_merge
      }
    }

    chapter "merge_conflicts" {
      title = "Handling Merge Conflicts"

      page "understanding_conflicts" {
        title = "Understanding Conflicts"
        reference = resource.page.understanding_conflicts
      }

      page "resolving_conflicts" {
        title = "Resolving Conflicts"
        reference = resource.page.resolving_conflicts
      }
    }

    chapter "working_with_remotes" {
      title = "Working with Remotes"

      page "cloning" {
        title = "Cloning Repositories"
        reference = resource.page.cloning
      }

      page "pushing" {
        title = "Pushing Changes"
        reference = resource.page.pushing
      }

      page "pulling" {
        title = "Pulling Changes"
        reference = resource.page.pulling
      }
    }

    chapter "collaboration_basics" {
      title = "Collaboration Basics"

      page "multi_developer" {
        title = "Multi-Developer Workflow"
        reference = resource.page.multi_developer
      }

      page "conclusion" {
        title = "Conclusion"
        reference = resource.page.conclusion
      }
    }
  }
}
```

#### 3. Lab Description
**File**: `git-fundamentals/description.md`

```markdown
# Git Fundamentals

Learn the essential Git commands and workflows through hands-on practice. This lab teaches you how to manage code with Git, work with branches, handle merge conflicts, and collaborate with remotes.

## What You'll Learn

- Initialize Git repositories and configure your identity
- Make commits and navigate project history
- Create and merge branches
- Resolve merge conflicts
- Work with remote repositories
- Understand the core Git workflow

## Prerequisites

No prior Git experience required. Basic command-line familiarity is helpful but not mandatory.

## Duration

Approximately 60-90 minutes

---

*This lab uses pre-configured environments to let you focus on learning Git commands without worrying about authentication or setup.*
```

### Success Criteria

#### Automated Verification:
- [x] Directory structure created successfully: `ls git-fundamentals/`
- [x] All HCL files are syntactically valid: `cd git-fundamentals && instruqt lab validate .`
- [x] Lab metadata is correct (title, description, tags)

#### Manual Verification:
- [x] Directory structure matches planned layout
- [x] File paths reference correct instruction files
- [x] Chapter progression makes logical sense

---

## Phase 2: Sandbox Infrastructure

### Overview
Configure the container environment with Git pre-installed, networking, terminal access, and bare repository setup for remote operations.

### Changes Required

#### 1. Network and Container Configuration
**File**: `git-fundamentals/sandbox.hcl`

```hcl
resource "network" "main" {
  subnet = "10.0.5.0/24"
}

resource "container" "git_workstation" {
  image {
    name = "ubuntu:22.04"
  }

  network {
    id = resource.network.main.meta.id
  }

  # Install Git and keep container running
  command = [
    "/bin/bash",
    "-c",
    "apt-get update -qq && apt-get install -y -qq git tree > /dev/null 2>&1 && /root/setup.sh && tail -f /dev/null"
  ]

  # Mount setup script
  volume {
    source      = data("setup")
    destination = "/root/setup.sh"
  }
}
```

#### 2. Container Startup Script
**File**: `git-fundamentals/scripts/setup/container_startup.sh`

This script will be copied to `/root/setup.sh` in the container and executed during startup.

```bash
#!/bin/bash
set -e

# Configure Git identity (pre-configured for students)
git config --global user.name "Lab Student"
git config --global user.email "student@instruqt.lab"
git config --global init.defaultBranch main
git config --global core.editor "nano"

# Create directory for bare repositories (hidden from students)
mkdir -p /opt/git

# Create primary bare repository for remote exercises
mkdir -p /opt/git/origin.git
cd /opt/git/origin.git
git init --bare --quiet

# Create a second bare repo for collaboration exercises
mkdir -p /opt/git/team-project.git
cd /opt/git/team-project.git
git init --bare --quiet

# Initialize with a README so students have something to clone
cd /tmp/init-repo
git init --quiet
echo "# Team Project" > README.md
echo "Welcome to the team project repository!" >> README.md
git add README.md
git commit --quiet -m "Initial commit"
git remote add origin /opt/git/team-project.git
git push --quiet origin main
cd /
rm -rf /tmp/init-repo

# Create student workspace directories
mkdir -p /root/workspace
mkdir -p /root/dev1
mkdir -p /root/dev2

# Set up initial workspace for chapters 1-6
cd /root/workspace
echo "Student workspace ready" > .workspace_ready

echo "Git lab environment initialized successfully!"
```

#### 3. Template Resource for Setup Script
**File**: `git-fundamentals/sandbox.hcl` (addition)

Add this to the sandbox.hcl file after the container resource:

```hcl
resource "copy" "setup_script" {
  source      = "scripts/setup/container_startup.sh"
  destination = data("setup")
}
```

#### 4. Terminal Configuration
**File**: `git-fundamentals/tabs.hcl`

```hcl
resource "terminal" "shell" {
  title = "Git Terminal"

  target = resource.container.git_workstation
  shell = "/bin/bash"
  working_directory = "/root/workspace"
  user = "root"
  theme = "dracula"

  # Custom prompt showing current Git branch
  prompt = "\\[\\033[01;32m\\]\\u@git-lab\\[\\033[00m\\]:\\[\\033[01;34m\\]\\w\\[\\033[00m\\]\\$ "
}
```

#### 5. Layout Configuration
**File**: `git-fundamentals/layouts.hcl`

```hcl
resource "layout" "terminal_instructions" {
  column {
    width = 60

    tab "terminal" {
      target = resource.terminal.shell
    }
  }

  column {
    width = 40

    instructions {}
  }
}

resource "layout" "instructions_only" {
  column {
    instructions {}
  }
}
```

### Success Criteria

#### Automated Verification:
- [x] Sandbox validates: `instruqt lab validate git-fundamentals/`
- [x] Container builds successfully
- [x] Git is installed: `git --version` returns version
- [x] Git identity configured: `git config --global user.name` returns "Lab Student"
- [x] Bare repos exist: `ls /opt/git/origin.git` and `ls /opt/git/team-project.git`
- [x] Workspace directory exists: `ls /root/workspace`

#### Manual Verification:
- [x] Container starts within 30 seconds
- [x] Terminal is accessible and responsive
- [x] Git commands work in terminal
- [x] Working directory is `/root/workspace` on terminal load

---

## Phase 3: Page Resources and Instruction Content

### Overview
Create all page resources and write comprehensive markdown instruction content for each chapter, adapted from Beej's Guide Chapters 2-6.

### Changes Required

#### 1. Page Resource Definitions
**File**: `git-fundamentals/pages.hcl`

```hcl
# Chapter 1: Git Basics
resource "page" "what_is_git" {
  title = "What is Git?"
  file = "instructions/01_git_basics/what_is_git.md"
}

resource "page" "configuration" {
  title = "Configuration"
  file = "instructions/01_git_basics/configuration.md"

  activities = {
    "git_configured" = resource.task.git_configured
  }
}

# Chapter 2: First Repository
resource "page" "init" {
  title = "Initializing a Repository"
  file = "instructions/02_first_repository/init.md"

  activities = {
    "repo_initialized" = resource.task.repo_initialized
  }
}

resource "page" "first_commit" {
  title = "Making Your First Commit"
  file = "instructions/02_first_repository/first_commit.md"

  activities = {
    "first_commit" = resource.task.first_commit
  }
}

resource "page" "viewing_history" {
  title = "Viewing Commit History"
  file = "instructions/02_first_repository/viewing_history.md"
}

# Chapter 3: Working with Files
resource "page" "staging" {
  title = "Staging Changes"
  file = "instructions/03_working_with_files/staging.md"

  activities = {
    "staged_files" = resource.task.staged_files
  }
}

resource "page" "commit_workflow" {
  title = "The Commit Workflow"
  file = "instructions/03_working_with_files/commit_workflow.md"
}

resource "page" "gitignore" {
  title = "Ignoring Files"
  file = "instructions/03_working_with_files/gitignore.md"

  activities = {
    "gitignore_working" = resource.task.gitignore_working
  }
}

# Chapter 4: Understanding History
resource "page" "git_log" {
  title = "Exploring Git Log"
  file = "instructions/04_understanding_history/git_log.md"
}

resource "page" "commit_navigation" {
  title = "Navigating Commits"
  file = "instructions/04_understanding_history/commit_navigation.md"
}

resource "page" "detached_head" {
  title = "Detached HEAD State"
  file = "instructions/04_understanding_history/detached_head.md"
}

# Chapter 5: Branching Basics
resource "page" "creating_branches" {
  title = "Creating Branches"
  file = "instructions/05_branching_basics/creating_branches.md"

  activities = {
    "branch_created" = resource.task.branch_created
  }
}

resource "page" "switching_branches" {
  title = "Switching Branches"
  file = "instructions/05_branching_basics/switching_branches.md"
}

resource "page" "fast_forward_merge" {
  title = "Fast-Forward Merges"
  file = "instructions/05_branching_basics/fast_forward_merge.md"

  activities = {
    "branch_merged" = resource.task.branch_merged
  }
}

# Chapter 6: Merge Conflicts
resource "page" "understanding_conflicts" {
  title = "Understanding Conflicts"
  file = "instructions/06_merge_conflicts/understanding_conflicts.md"
}

resource "page" "resolving_conflicts" {
  title = "Resolving Conflicts"
  file = "instructions/06_merge_conflicts/resolving_conflicts.md"

  activities = {
    "conflict_resolved" = resource.task.conflict_resolved
  }
}

# Chapter 7: Working with Remotes
resource "page" "cloning" {
  title = "Cloning Repositories"
  file = "instructions/07_working_with_remotes/cloning.md"

  activities = {
    "remote_cloned" = resource.task.remote_cloned
  }
}

resource "page" "pushing" {
  title = "Pushing Changes"
  file = "instructions/07_working_with_remotes/pushing.md"

  activities = {
    "changes_pushed" = resource.task.changes_pushed
  }
}

resource "page" "pulling" {
  title = "Pulling Changes"
  file = "instructions/07_working_with_remotes/pulling.md"

  activities = {
    "changes_pulled" = resource.task.changes_pulled
  }
}

# Chapter 8: Collaboration Basics
resource "page" "multi_developer" {
  title = "Multi-Developer Workflow"
  file = "instructions/08_collaboration_basics/multi_developer.md"
}

resource "page" "conclusion" {
  title = "Conclusion"
  file = "instructions/08_collaboration_basics/conclusion.md"
}
```

#### 2. Sample Instruction Content
**File**: `git-fundamentals/instructions/01_git_basics/what_is_git.md`

```markdown
# What is Git?

Git is a **distributed version control system** that helps you track changes to your code over time. Think of it as a sophisticated "undo" system that lets you:

- Save snapshots of your project at any point
- Collaborate with others without overwriting each other's work
- Experiment with new ideas on separate branches
- Revert to previous versions if something breaks

## Key Concepts

### Repository
A repository (or "repo") is a directory that Git tracks. It contains all your project files plus a hidden `.git` directory where Git stores its history and metadata.

### Commit
A commit is a snapshot of your project at a specific point in time. Each commit has:
- A unique identifier (SHA hash)
- An author and timestamp
- A commit message describing the changes
- A pointer to the previous commit(s)

### Branch
A branch is a lightweight movable pointer to a commit. The default branch is called `main`. Branches let you work on features independently.

### Remote
A remote is a version of your repository hosted elsewhere (like on a server or another computer). In this lab, we use pre-configured remotes so you can practice collaboration without authentication setup.

## Why Git?

Git has become the industry standard for version control because:

1. **Distributed**: Everyone has a complete copy of the repository
2. **Fast**: Most operations are local and nearly instantaneous
3. **Branching**: Creating and merging branches is lightweight and efficient
4. **Integrity**: Everything is checksummed, preventing corruption
5. **Collaboration**: Multiple people can work simultaneously on the same codebase

In this lab, you'll learn Git fundamentals through hands-on practice. Let's get started!

---

**Next:** Configure your Git identity
```

**File**: `git-fundamentals/instructions/01_git_basics/configuration.md`

```markdown
# Git Configuration

Before using Git, you need to tell it who you are. This information is attached to every commit you make.

## Your Identity

Your Git identity has two parts:
- **Name**: Your name (or username)
- **Email**: Your email address

## Checking Current Configuration

Your Git identity has already been pre-configured for this lab, but let's verify it.

Run this command to see your configured name:

```bash
git config --global user.name
```

You should see: `Lab Student`

Now check your email:

```bash
git config --global user.email
```

You should see: `student@instruqt.lab`

## How Configuration Works

Git has three levels of configuration:

1. **System** (`--system`): Applies to all users on the system
2. **Global** (`--global`): Applies to your user account
3. **Local** (default): Applies only to the current repository

The `--global` flag means these settings apply to all repositories for your user.

## Other Useful Settings

Let's check a few other pre-configured settings:

```bash
# Default branch name
git config --global init.defaultBranch

# Default text editor
git config --global core.editor
```

The default branch is set to `main` (the modern standard), and the editor is `nano` (a beginner-friendly terminal editor).

## Viewing All Configuration

To see all your Git configuration at once:

```bash
git config --list
```

This shows every setting Git knows about.

## Task

Verify that your Git configuration is correct by running the commands above. When you're ready, check the box below to continue.

<instruqt-task id="git_configured"></instruqt-task>

---

**Next:** Create your first Git repository
```

**File**: `git-fundamentals/instructions/02_first_repository/init.md`

```markdown
# Initializing a Repository

To start tracking a project with Git, you need to initialize a repository. This creates the `.git` directory where Git stores all its metadata.

## Creating a New Repository

Let's create a simple project and initialize Git:

```bash
# Create a new directory for your project
mkdir my-project
cd my-project

# Initialize Git
git init
```

You should see: `Initialized empty Git repository in /root/workspace/my-project/.git/`

## What Just Happened?

The `git init` command created a hidden `.git` directory inside your project. This directory contains:

- `objects/` - All your commits and file snapshots
- `refs/` - Branch and tag references
- `HEAD` - Points to your current branch
- `config` - Repository-specific configuration

Let's take a look:

```bash
ls -la
```

You'll see `.git` in the listing. This is Git's database for your project.

## Checking Repository Status

At any time, you can check the status of your repository:

```bash
git status
```

Right now, you'll see:

```
On branch main

No commits yet

nothing to commit (create/copy files and use "git add" to track)
```

This tells you:
- You're on the `main` branch
- No commits have been made yet
- No files are ready to be committed

## Task

Initialize a Git repository in a directory called `my-project` in your workspace (`/root/workspace/`). When you've successfully initialized it, complete the task below.

<instruqt-task id="repo_initialized"></instruqt-task>

---

**Next:** Make your first commit
```

**File**: `git-fundamentals/instructions/02_first_repository/first_commit.md`

```markdown
# Making Your First Commit

Now that you have a Git repository, let's create your first commit. A commit is a snapshot of your project at a specific moment.

## The Three-Step Workflow

Every commit follows this pattern:

1. **Modify** - Change files in your working directory
2. **Stage** - Select which changes to include in the next commit
3. **Commit** - Create a snapshot with a descriptive message

Let's walk through each step.

## Step 1: Create a File

First, let's create a file in your repository:

```bash
cd /root/workspace/my-project
echo "# My Project" > README.md
```

Now check the status:

```bash
git status
```

You'll see:

```
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        README.md

nothing added to commit but untracked files present (use "git add" to track)
```

Git sees the file but isn't tracking it yet.

## Step 2: Stage the File

Staging tells Git which changes you want to include in the next commit:

```bash
git add README.md
```

Check the status again:

```bash
git status
```

Now you'll see:

```
Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   README.md
```

The file is now **staged** and ready to be committed.

## Step 3: Commit the Changes

Create a commit with a descriptive message:

```bash
git commit -m "Add README file"
```

The `-m` flag lets you provide a commit message inline. You should see output like:

```
[main (root-commit) a1b2c3d] Add README file
 1 file changed, 1 insertion(+)
 create mode 100644 README.md
```

Congratulations! You've made your first commit.

## Viewing Your Commit

See your commit history:

```bash
git log
```

You'll see:
- Commit hash (unique identifier)
- Author (you!)
- Date
- Commit message

Press `q` to exit the log viewer.

## Shorter Log Format

For a compact view:

```bash
git log --oneline
```

This shows just the hash and message on one line.

## Task

Create a file called `README.md` with some content, stage it with `git add`, and commit it with `git commit`. Your commit message should describe what you're committing.

<instruqt-task id="first_commit"></instruqt-task>

---

**Next:** Learn to view and navigate commit history
```

### Success Criteria

#### Automated Verification:
- [x] All page resources reference valid markdown files
- [x] Markdown files follow consistent formatting
- [x] Task placeholders `<instruqt-task id="..."></instruqt-task>` match task IDs in tasks.hcl
- [x] File paths in pages.hcl match actual instruction file locations

#### Manual Verification:
- [x] Instruction content is accurate and beginner-friendly
- [x] Code examples are correct and runnable
- [x] Progressive complexity flows naturally
- [x] Technical terms are explained when first introduced
- [x] Screenshots or diagrams are included where helpful (optional)

---

## Phase 4: Task Validation ✓ COMPLETE

### Overview
Create all task resources and validation scripts to provide automated feedback as students complete exercises.

**Implementation Notes:**
- Refactored to use multiple checks per condition for atomic validation
- Enhanced with 1:n page-to-task relationships for incremental validation
- All failure messages converted to learning hints rather than direct answers
- 15 total tasks with 4 new granular tasks added (create_readme, stage_readme, commits_on_branch, switch_to_main, make_changes_for_push)

### Changes Required

#### 1. Task Resource Definitions
**File**: `git-fundamentals/tasks.hcl`

```hcl
# Task: Git Configured
resource "task" "git_configured" {
  description = "Verify Git configuration is set correctly"

  config {
    target = resource.container.git_workstation
  }

  condition "name_configured" {
    description = "Git user name is configured"

    check {
      script = "scripts/git_configured/check.sh"
      failure_message = "Git user name is not configured correctly. Run: git config --global user.name"
    }
  }
}

# Task: Repository Initialized
resource "task" "repo_initialized" {
  description = "Initialize a Git repository in /root/workspace/my-project"

  config {
    target = resource.container.git_workstation
  }

  condition "git_directory_exists" {
    description = "Repository has been initialized"

    check {
      script = "scripts/repo_initialized/check.sh"
      failure_message = "Git repository not found. Make sure you ran 'git init' in /root/workspace/my-project"
    }
  }
}

# Task: First Commit
resource "task" "first_commit" {
  description = "Create a README.md file and make your first commit"

  config {
    target = resource.container.git_workstation
  }

  condition "commit_exists" {
    description = "At least one commit has been made"

    check {
      script = "scripts/first_commit/check.sh"
      failure_message = "No commits found. Create README.md, stage it with 'git add', and commit with 'git commit -m \"message\"'"
    }

    solve {
      script = "scripts/first_commit/solve.sh"
    }
  }
}

# Task: Files Staged
resource "task" "staged_files" {
  description = "Practice staging multiple files"

  config {
    target = resource.container.git_workstation
  }

  condition "multiple_files_staged" {
    description = "Multiple files are staged for commit"

    check {
      script = "scripts/staged_files/check.sh"
      failure_message = "Stage at least 2 files using 'git add'. Check 'git status' to see staged files."
    }
  }
}

# Task: Gitignore Working
resource "task" "gitignore_working" {
  description = "Create a .gitignore file to exclude files from Git"

  config {
    target = resource.container.git_workstation
  }

  condition "gitignore_exists" {
    description = ".gitignore file exists and is working"

    check {
      script = "scripts/gitignore_working/check.sh"
      failure_message = "Create a .gitignore file and add patterns to ignore files. Commit the .gitignore file."
    }
  }
}

# Task: Branch Created
resource "task" "branch_created" {
  description = "Create a new branch for feature development"

  config {
    target = resource.container.git_workstation
  }

  condition "branch_exists" {
    description = "A new branch has been created"

    check {
      script = "scripts/branch_created/check.sh"
      failure_message = "Create a new branch with 'git branch <branch-name>' or 'git checkout -b <branch-name>'"
    }
  }
}

# Task: Branch Merged
resource "task" "branch_merged" {
  description = "Merge a feature branch into main"

  config {
    target = resource.container.git_workstation
  }

  condition "merge_completed" {
    description = "Branch has been successfully merged"

    check {
      script = "scripts/branch_merged/check.sh"
      failure_message = "Merge your feature branch into main. Switch to main with 'git checkout main', then run 'git merge <branch-name>'"
    }
  }
}

# Task: Conflict Resolved
resource "task" "conflict_resolved" {
  description = "Resolve a merge conflict"

  config {
    target = resource.container.git_workstation
  }

  condition "conflict_fixed" {
    description = "Merge conflict has been resolved and committed"

    check {
      script = "scripts/conflict_resolved/check.sh"
      failure_message = "Resolve the conflict markers in the file, stage with 'git add', and complete the merge with 'git commit'"
    }
  }
}

# Task: Remote Cloned
resource "task" "remote_cloned" {
  description = "Clone a repository from the remote"

  config {
    target = resource.container.git_workstation
  }

  condition "clone_successful" {
    description = "Repository has been cloned from remote"

    check {
      script = "scripts/remote_cloned/check.sh"
      failure_message = "Clone the team-project repository with: git clone /opt/git/team-project.git"
    }
  }
}

# Task: Changes Pushed
resource "task" "changes_pushed" {
  description = "Push your commits to the remote repository"

  config {
    target = resource.container.git_workstation
  }

  condition "push_successful" {
    description = "Changes have been pushed to remote"

    check {
      script = "scripts/changes_pushed/check.sh"
      failure_message = "Push your commits with: git push origin main"
    }
  }
}

# Task: Changes Pulled
resource "task" "changes_pulled" {
  description = "Pull changes from the remote repository"

  config {
    target = resource.container.git_workstation
  }

  condition "pull_successful" {
    description = "Changes have been pulled from remote"

    check {
      script = "scripts/changes_pulled/check.sh"
      failure_message = "Pull remote changes with: git pull origin main"
    }
  }
}
```

#### 2. Check Script: Git Configured
**File**: `git-fundamentals/scripts/git_configured/check.sh`

```bash
#!/bin/bash

# Check if user.name is configured
USER_NAME=$(git config --global user.name)

if [ -z "$USER_NAME" ]; then
  echo "Git user name is not configured"
  exit 1
fi

# Check if user.email is configured
USER_EMAIL=$(git config --global user.email)

if [ -z "$USER_EMAIL" ]; then
  echo "Git user email is not configured"
  exit 1
fi

exit 0
```

#### 3. Check Script: Repository Initialized
**File**: `git-fundamentals/scripts/repo_initialized/check.sh`

```bash
#!/bin/bash

cd /root/workspace/my-project 2>/dev/null || exit 1

# Check if .git directory exists
if [ ! -d .git ]; then
  echo "No .git directory found. Run 'git init' to initialize the repository."
  exit 1
fi

# Verify it's a valid Git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  echo "Directory is not a valid Git repository"
  exit 1
fi

exit 0
```

#### 4. Check Script: First Commit
**File**: `git-fundamentals/scripts/first_commit/check.sh`

```bash
#!/bin/bash

cd /root/workspace/my-project 2>/dev/null || {
  echo "Project directory not found"
  exit 1
}

# Check if repository is initialized
if [ ! -d .git ]; then
  echo "Not a Git repository. Run 'git init' first."
  exit 1
fi

# Check if at least one commit exists
COMMIT_COUNT=$(git rev-list --count HEAD 2>/dev/null || echo "0")

if [ "$COMMIT_COUNT" -lt 1 ]; then
  echo "No commits found. Create a file, stage it with 'git add', and commit with 'git commit -m \"message\"'"
  exit 1
fi

# Check if README.md exists and is committed
if ! git ls-files | grep -q "README.md"; then
  echo "README.md not found in repository. Add and commit README.md"
  exit 1
fi

exit 0
```

#### 5. Solve Script: First Commit
**File**: `git-fundamentals/scripts/first_commit/solve.sh`

```bash
#!/bin/bash

cd /root/workspace/my-project || exit 1

# Create README if it doesn't exist
if [ ! -f README.md ]; then
  echo "# My Project" > README.md
fi

# Stage and commit
git add README.md
git commit -m "Add README file" > /dev/null 2>&1

exit 0
```

#### 6. Check Script: Staged Files
**File**: `git-fundamentals/scripts/staged_files/check.sh`

```bash
#!/bin/bash

cd /root/workspace/my-project 2>/dev/null || exit 1

# Count staged files
STAGED_COUNT=$(git diff --cached --name-only | wc -l)

if [ "$STAGED_COUNT" -lt 2 ]; then
  echo "Not enough files staged. Stage at least 2 files using 'git add <file>'"
  exit 1
fi

exit 0
```

#### 7. Check Script: Gitignore Working
**File**: `git-fundamentals/scripts/gitignore_working/check.sh`

```bash
#!/bin/bash

cd /root/workspace/my-project 2>/dev/null || exit 1

# Check if .gitignore exists
if [ ! -f .gitignore ]; then
  echo ".gitignore file not found. Create it with patterns to ignore files."
  exit 1
fi

# Check if .gitignore is committed
if ! git ls-files | grep -q "^\.gitignore$"; then
  echo ".gitignore exists but is not committed. Stage and commit it."
  exit 1
fi

# Check if .gitignore has content
if [ ! -s .gitignore ]; then
  echo ".gitignore is empty. Add patterns to ignore files (e.g., *.log, temp/)"
  exit 1
fi

exit 0
```

#### 8. Check Script: Branch Created
**File**: `git-fundamentals/scripts/branch_created/check.sh`

```bash
#!/bin/bash

cd /root/workspace/my-project 2>/dev/null || exit 1

# Get all branches except main
BRANCH_COUNT=$(git branch | grep -v "main" | grep -v "^*" | wc -l)

if [ "$BRANCH_COUNT" -lt 1 ]; then
  echo "No branches found besides main. Create a new branch with 'git branch <name>' or 'git checkout -b <name>'"
  exit 1
fi

exit 0
```

#### 9. Check Script: Branch Merged
**File**: `git-fundamentals/scripts/branch_merged/check.sh`

```bash
#!/bin/bash

cd /root/workspace/my-project 2>/dev/null || exit 1

# Must be on main branch
CURRENT_BRANCH=$(git branch --show-current)

if [ "$CURRENT_BRANCH" != "main" ]; then
  echo "Switch to main branch first with 'git checkout main'"
  exit 1
fi

# Check if there's evidence of a merge (more than 1 commit on main)
COMMIT_COUNT=$(git rev-list --count HEAD 2>/dev/null)

if [ "$COMMIT_COUNT" -lt 2 ]; then
  echo "No merge detected. Create commits on a feature branch and merge into main."
  exit 1
fi

exit 0
```

#### 10. Check Script: Conflict Resolved
**File**: `git-fundamentals/scripts/conflict_resolved/check.sh`

```bash
#!/bin/bash

cd /root/workspace/my-project 2>/dev/null || exit 1

# Check if merge is in progress
if [ -d .git/MERGE_HEAD ]; then
  echo "Merge still in progress. Resolve conflicts, stage files, and run 'git commit'"
  exit 1
fi

# Check for conflict markers in tracked files
if git grep -q "^<<<<<<< HEAD" 2>/dev/null; then
  echo "Conflict markers still present. Edit the file to resolve conflicts."
  exit 1
fi

exit 0
```

#### 11. Check Script: Remote Cloned
**File**: `git-fundamentals/scripts/remote_cloned/check.sh`

```bash
#!/bin/bash

# Check if team-project directory exists
if [ ! -d /root/workspace/team-project ]; then
  echo "Team project not found. Clone it with: git clone /opt/git/team-project.git"
  exit 1
fi

cd /root/workspace/team-project || exit 1

# Check if it's a git repo
if [ ! -d .git ]; then
  echo "team-project is not a Git repository"
  exit 1
fi

# Check if origin remote is configured
if ! git remote -v | grep -q "origin"; then
  echo "No origin remote configured"
  exit 1
fi

exit 0
```

#### 12. Check Script: Changes Pushed
**File**: `git-fundamentals/scripts/changes_pushed/check.sh`

```bash
#!/bin/bash

cd /root/workspace/team-project 2>/dev/null || exit 1

# Check if there are unpushed commits
UNPUSHED=$(git log origin/main..HEAD --oneline 2>/dev/null | wc -l)

if [ "$UNPUSHED" -gt 0 ]; then
  echo "You have unpushed commits. Push them with: git push origin main"
  exit 1
fi

exit 0
```

#### 13. Check Script: Changes Pulled
**File**: `git-fundamentals/scripts/changes_pulled/check.sh`

```bash
#!/bin/bash

cd /root/workspace/team-project 2>/dev/null || exit 1

# Fetch latest changes
git fetch origin > /dev/null 2>&1

# Check if local main is up to date with origin/main
LOCAL=$(git rev-parse main 2>/dev/null)
REMOTE=$(git rev-parse origin/main 2>/dev/null)

if [ "$LOCAL" != "$REMOTE" ]; then
  echo "Local branch is behind origin/main. Pull changes with: git pull origin main"
  exit 1
fi

exit 0
```

### Success Criteria

#### Automated Verification:
- [x] All check scripts are executable: `chmod +x scripts/*/check.sh`
- [x] All solve scripts are executable: `chmod +x scripts/*/solve.sh`
- [x] Check scripts return exit code 0 on success, non-zero on failure
- [x] Check scripts run successfully when conditions are met
- [x] Solve scripts create the expected state

#### Manual Verification:
- [x] Failure messages are helpful and actionable
- [x] Check scripts don't have false positives
- [x] Check scripts don't have false negatives
- [x] Tasks validate in reasonable time (< 5 seconds each)

---

## Phase 5: Remaining Instruction Content

### Overview
Complete all remaining instruction markdown files for chapters 3-8, ensuring comprehensive coverage of all topics.

### Changes Required

This phase involves writing the remaining 16 instruction files. Due to length, I'll provide templates and guidelines rather than full content for every file.

#### Template Structure for Instruction Files

Each instruction file should follow this pattern:

```markdown
# [Topic Title]

[Brief introduction explaining the concept - 2-3 sentences]

## [Section Heading]

[Content with explanations]

### [Sub-section if needed]

[Detailed explanation]

## [Hands-On Section]

[Step-by-step instructions with code blocks]

```bash
# Example command
git <command>
```

[Expected output or explanation]

## [Key Points / Summary]

[Bulleted list of key takeaways]

## Task

[Instructions for the task, if applicable]

<instruqt-task id="task_id"></instruqt-task>

---

**Next:** [Link to next concept]
```

#### Files to Create

1. **instructions/03_working_with_files/staging.md** - Staging area concepts, `git add`, `git reset`
2. **instructions/03_working_with_files/commit_workflow.md** - Modify → Stage → Commit cycle
3. **instructions/04_understanding_history/git_log.md** - `git log` variations, formatting
4. **instructions/04_understanding_history/commit_navigation.md** - HEAD, HEAD~, HEAD^
5. **instructions/04_understanding_history/detached_head.md** - What it is, when it happens, how to recover
6. **instructions/05_branching_basics/creating_branches.md** - `git branch`, `git checkout -b`
7. **instructions/05_branching_basics/switching_branches.md** - `git checkout`, `git switch`
8. **instructions/05_branching_basics/fast_forward_merge.md** - What FF merges are, when they happen
9. **instructions/06_merge_conflicts/understanding_conflicts.md** - Why conflicts happen, conflict markers
10. **instructions/06_merge_conflicts/resolving_conflicts.md** - Manual resolution, staging, committing
11. **instructions/07_working_with_remotes/cloning.md** - `git clone`, understanding origin
12. **instructions/07_working_with_remotes/pushing.md** - `git push`, tracking branches
13. **instructions/07_working_with_remotes/pulling.md** - `git pull`, fetch + merge
14. **instructions/08_collaboration_basics/multi_developer.md** - Simulating team workflow
15. **instructions/08_collaboration_basics/conclusion.md** - Summary, next steps

#### Content Guidelines

- **Be concise**: Students should spend time practicing, not reading walls of text
- **Use examples**: Every concept should have a runnable code example
- **Show output**: Include expected Git output after commands
- **Build progressively**: Each file assumes knowledge from previous files
- **Explain errors**: Show common errors and how to fix them
- **Visual aids**: Use ASCII art or suggest diagrams where helpful

### Success Criteria

#### Automated Verification:
- [x] All instruction files exist in correct directories
- [x] All markdown files are valid (no syntax errors)
- [x] Task placeholders reference valid task IDs
- [x] Code blocks use correct syntax highlighting

#### Manual Verification:
- [x] Content flows logically from chapter to chapter
- [x] Technical accuracy verified for all commands
- [x] Explanations are beginner-friendly
- [x] All commands are runnable in the lab environment
- [x] Consistent terminology throughout

---

## Phase 6: Testing and Validation

### Overview
Thoroughly test the complete lab to ensure all components work together correctly.

### Changes Required

#### 1. Validation Checklist Script
**File**: `git-fundamentals/scripts/validate_lab.sh`

```bash
#!/bin/bash
# Lab validation script - run this to check lab configuration

set -e

echo "Validating Git Fundamentals Lab..."

# Check HCL syntax
echo "✓ Validating HCL files..."
instruqt lab validate /Users/erik/code/instruqt/labs/git/git-fundamentals

# Check all instruction files exist
echo "✓ Checking instruction files..."
for chapter in 01_git_basics 02_first_repository 03_working_with_files 04_understanding_history 05_branching_basics 06_merge_conflicts 07_working_with_remotes 08_collaboration_basics; do
  if [ ! -d "instructions/$chapter" ]; then
    echo "  ✗ Missing directory: instructions/$chapter"
    exit 1
  fi
done

# Check all check scripts exist and are executable
echo "✓ Checking validation scripts..."
for script in git_configured repo_initialized first_commit staged_files gitignore_working branch_created branch_merged conflict_resolved remote_cloned changes_pushed changes_pulled; do
  if [ ! -f "scripts/$script/check.sh" ]; then
    echo "  ✗ Missing check script: scripts/$script/check.sh"
    exit 1
  fi
  if [ ! -x "scripts/$script/check.sh" ]; then
    echo "  ✗ Check script not executable: scripts/$script/check.sh"
    chmod +x "scripts/$script/check.sh"
  fi
done

# Check setup script exists and is executable
echo "✓ Checking setup script..."
if [ ! -x "scripts/setup/container_startup.sh" ]; then
  chmod +x "scripts/setup/container_startup.sh"
fi

echo ""
echo "✅ All validation checks passed!"
echo ""
echo "Next steps:"
echo "1. Test the lab locally if possible"
echo "2. Deploy to Instruqt staging environment"
echo "3. Complete full lab walkthrough manually"
echo "4. Fix any issues discovered"
echo "5. Deploy to production"
```

#### 2. Manual Testing Checklist
**File**: `git-fundamentals/TESTING.md`

```markdown
# Git Fundamentals Lab - Testing Checklist

## Pre-Deployment Testing

### Configuration Validation
- [ ] Run `instruqt lab validate .` - No errors
- [ ] All HCL files parse correctly
- [ ] All file references are valid

### Container Testing
- [ ] Container builds successfully
- [ ] Git is installed and accessible
- [ ] Git version is modern (2.x)
- [ ] Setup script executes without errors
- [ ] Bare repositories created in /opt/git/
- [ ] Git identity pre-configured
- [ ] Workspace directories exist

### Task Validation Testing
Test each task check script:

- [ ] git_configured: Passes when Git is configured
- [ ] repo_initialized: Passes when repo exists
- [ ] first_commit: Passes when commit made
- [ ] staged_files: Passes when 2+ files staged
- [ ] gitignore_working: Passes when .gitignore committed
- [ ] branch_created: Passes when branch created
- [ ] branch_merged: Passes when branch merged
- [ ] conflict_resolved: Passes when conflict resolved
- [ ] remote_cloned: Passes when repo cloned
- [ ] changes_pushed: Passes when changes pushed
- [ ] changes_pulled: Passes when changes pulled

### Content Testing
- [ ] All instruction pages load correctly
- [ ] Markdown renders properly
- [ ] Code blocks are formatted correctly
- [ ] Task placeholders activate tasks
- [ ] Internal links work correctly

## Full Lab Walkthrough

Complete the lab from start to finish:

- [ ] Chapter 1: Git Basics
  - [ ] "What is Git?" page renders
  - [ ] "Configuration" page renders
  - [ ] git_configured task validates

- [ ] Chapter 2: First Repository
  - [ ] "Initializing a Repository" page renders
  - [ ] repo_initialized task validates
  - [ ] "Making Your First Commit" page renders
  - [ ] first_commit task validates
  - [ ] "Viewing Commit History" page renders

- [ ] Chapter 3: Working with Files
  - [ ] "Staging Changes" page renders
  - [ ] staged_files task validates
  - [ ] "The Commit Workflow" page renders
  - [ ] "Ignoring Files" page renders
  - [ ] gitignore_working task validates

- [ ] Chapter 4: Understanding History
  - [ ] All pages render correctly
  - [ ] Commands in examples work as shown

- [ ] Chapter 5: Branching Basics
  - [ ] branch_created task validates
  - [ ] branch_merged task validates

- [ ] Chapter 6: Merge Conflicts
  - [ ] conflict_resolved task validates
  - [ ] Conflict resolution instructions are clear

- [ ] Chapter 7: Working with Remotes
  - [ ] remote_cloned task validates
  - [ ] changes_pushed task validates
  - [ ] changes_pulled task validates

- [ ] Chapter 8: Collaboration Basics
  - [ ] All pages render correctly
  - [ ] Multi-developer scenario works

## Performance Testing
- [ ] Container starts in < 30 seconds
- [ ] Terminal is responsive
- [ ] Task validation completes in < 5 seconds
- [ ] No memory leaks or performance degradation

## Error Handling
- [ ] Helpful error messages for common mistakes
- [ ] Students can recover from errors
- [ ] Task failure messages are actionable

## Accessibility
- [ ] Instructions are clear for beginners
- [ ] No assumed prior knowledge
- [ ] Technical terms are explained

## Sign-off
- [ ] All automated tests pass
- [ ] Full walkthrough completed successfully
- [ ] No blocking issues identified
- [ ] Ready for production deployment
```

### Success Criteria

#### Automated Verification:
- [x] Validation script runs without errors: `bash scripts/validate_lab.sh`
- [ ] All check scripts pass when conditions are met
- [ ] All check scripts fail appropriately when conditions aren't met
- [x] `instruqt lab validate` reports 0 errors

#### Manual Verification:
- [ ] Complete lab walkthrough finished successfully
- [ ] All tasks can be completed
- [ ] All instruction content is accurate
- [ ] Terminal and UI are responsive
- [ ] No JavaScript errors in browser console
- [ ] Lab completes in 60-90 minutes for target audience

---

## Testing Strategy

### Unit Tests (Validation Scripts)

Each check script is a unit test for a specific Git state. Test each independently:

```bash
# Example: Test first_commit check script
cd /root/workspace/my-project
# Set up conditions (make a commit)
# Run check script
bash /path/to/check.sh
# Verify exit code is 0
```

### Integration Tests

Test the full lab workflow from start to finish in a deployed environment. Verify:

1. Container starts successfully
2. All chapters are accessible
3. Tasks validate correctly
4. Terminal works properly
5. No console errors

### Manual Testing Steps

1. **Deploy to staging**: Deploy lab to Instruqt staging environment
2. **Complete walkthrough**: Go through every chapter as a student would
3. **Test edge cases**: Try to break things intentionally
4. **Verify tasks**: Ensure tasks pass when they should and fail when they should
5. **Check timing**: Verify lab can be completed in target time (60-90 min)

### Performance Considerations

- Container startup should complete in < 30 seconds
- Task validation should complete in < 5 seconds
- Terminal should be immediately responsive
- No noticeable lag when switching between pages

## Migration Notes

N/A - This is a new lab, no migration from existing systems.

## References

- Original research: `thoughts/shared/research/2025-11-07-01-instruqt-git-lab-design.md`
- Beej's Git Guide: https://beej.us/guide/bggit/html/split/
- Instruqt HCL examples: `/Users/erik/code/instruqt/lab-examples/`
- Minimal lab example: `/Users/erik/code/instruqt/lab-examples/minimal/`
- Test lab example: `/Users/erik/code/instruqt/test-lab/`
