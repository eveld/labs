---
date: 2025-11-07T08:55:28+0100
researcher: erik
git_commit: N/A
branch: N/A
repository: instruqt/labs
topic: "Designing an Instruqt Git Tutorial Lab Series Using Beej's Guide"
tags: [research, instruqt, git, lab-design, hcl, tutorial, bare-repositories]
status: complete
last_updated: 2025-11-07
last_updated_by: erik
last_updated_note: "Revised to use bare repositories instead of GitHub for simpler, more focused Git learning"
---

# Research: Designing an Instruqt Git Tutorial Lab Series Using Beej's Guide

## Research Question

How should I structure an Instruqt lab series about Git using the new HCL format, based on Beej's comprehensive Git guide, splitting beginner/standard usage from advanced/edge cases?

## Summary

After researching the Instruqt lab HCL format, analyzing Beej's Git guide structure (32 chapters), and examining existing lab patterns in the codebase, I recommend creating **3 core labs** (not chapters within one lab) focused purely on Git mechanics without GitHub dependencies:

1. **Git Fundamentals** (Beginner) - Chapters 2-6 (adapted)
2. **Git Collaboration & History** (Intermediate) - Chapters 7-16, 18
3. **Advanced Git Operations** (Advanced) - Chapters 19-23, 24-32 (selected topics)

**Key Decision: Use pre-configured bare repositories behind the scenes** to avoid authentication overhead and focus purely on Git concepts. Students interact with `origin` just like they would with GitHub, without needing to understand the infrastructure. GitHub-specific features (forking, PRs via web UI) are optional bonus content.

Each lab should use the modular chapter pattern found in existing labs, with containers for hands-on terminal work, validation tasks, and progressive complexity.

## Detailed Findings

### Instruqt Lab HCL Structure

The new HCL format uses multiple configuration files with clear separation of concerns:

**Core Files:**
- `main.hcl` - Lab resource definition with title, description, settings, layout, and content structure
- `sandbox.hcl` - Infrastructure (containers, networks, terminals, cloud resources)
- `pages.hcl` - Content page resources referencing markdown instruction files
- `layouts.hcl` - UI column/tab arrangements
- `tasks.hcl` - Interactive validation challenges (optional)
- `activities.hcl` - Activities like tasks and quizzes (optional)
- `modules.hcl` - Module declarations for reusable components (optional)

**Directory Structure:**
```
lab-name/
├── main.hcl
├── sandbox.hcl
├── pages.hcl
├── layouts.hcl
├── tasks.hcl (optional)
├── instructions/
│   ├── chapter1/
│   │   ├── intro.md
│   │   └── exercise.md
│   └── chapter2/
├── scripts/
│   └── task_name/
│       ├── check.sh
│       └── solve.sh
└── modules/ (optional)
    └── chapters/
```

**Key HCL Patterns:**

Lab resource:
```hcl
resource "lab" "git_fundamentals" {
  title = "Git Fundamentals"
  description = file("description.md")

  settings {
    idle {
      enabled = true
      timeout = 3600
    }
  }

  layout = resource.layout.terminal_instructions

  content {
    chapter "basics" {
      title = "Git Basics"
      page "intro" {
        title = "Introduction"
        reference = resource.page.intro
      }
    }
  }
}
```

Sandbox with container and terminal:
```hcl
resource "network" "main" {
  subnet = "10.0.5.0/24"
}

resource "container" "workstation" {
  image {
    name = "ubuntu:22.04"
  }

  network {
    id = resource.network.main.meta.id
  }

  command = ["tail", "-f", "/dev/null"]
}

resource "terminal" "shell" {
  target = resource.container.workstation
  shell = "/bin/bash"
  working_directory = "/root/repo"
}
```

Layout (two-column with terminal):
```hcl
resource "layout" "terminal_instructions" {
  column {
    tab "terminal" {
      target = resource.terminal.shell
    }
  }

  column {
    width = 33
    instructions {}
  }
}
```

Task with validation:
```hcl
resource "task" "first_commit" {
  description = "Create your first commit"

  config {
    target = resource.container.workstation
  }

  condition "committed" {
    description = "Check if commit was created"

    check {
      script = "scripts/first_commit/check.sh"
      failure_message = "No commits found. Did you run 'git commit'?"
    }

    solve {
      script = "scripts/first_commit/solve.sh"
    }
  }
}
```

### Beej's Git Guide Structure Analysis

Beej's guide contains **32 core chapters** plus 6 appendices, covering beginner through advanced Git concepts. Here's the natural breakdown:

#### Part 1: Git Fundamentals (Chapters 2-6, adapted)
**Difficulty:** Beginner
**Duration:** 60-90 minutes

**Topics:**
- Git basics and repository concepts
- The init → modify → stage → commit workflow
- Working with remotes (pre-configured, just like using GitHub)
- Understanding commit history and HEAD
- Detached HEAD states
- Relative commit notation (HEAD~, HEAD^)
- Branch creation and management
- Fast-forward merges
- Basic merge conflict resolution

**Key Commands:** `git init`, `git add`, `git commit`, `git log`, `git checkout`, `git branch`, `git merge`, `git clone`, `git push`, `git pull`

**Hands-On Exercises:**
- Configure Git identity
- Initialize a repository
- Stage and commit changes
- Clone from a pre-configured remote
- Push to remote (already set up)
- Navigate commit history
- Explore detached HEAD safely
- Create and merge branches
- Resolve a simple merge conflict

**Note:** Remotes are pre-configured in the lab environment. Students interact with them just like they would with GitHub, without needing to understand bare repository mechanics initially.

#### Part 2: File Management & History (Chapters 7-16, 18)
**Difficulty:** Intermediate
**Duration:** 90-120 minutes

**Topics:**
- Repository structure and subdirectories
- .gitignore patterns
- Remote tracking branches (origin/main)
- Working with multiple remotes
- File states (untracked, unmodified, modified, staged)
- Using git diff (working directory, staging area, commits, branches)
- Renaming and removing files with Git tracking
- Recovering deleted files
- Team collaboration patterns
- Rebasing (linear history, interactive rebase, commit squashing)
- Stashing work in progress
- Reverting commits

**Key Commands:** `git remote`, `git push -u`, `git status`, `git diff`, `git mv`, `git rm`, `git restore`, `git rebase`, `git rebase -i`, `git stash`, `git revert`

**Hands-On Exercises:**
- Configure .gitignore with complex patterns
- Track file state transitions
- Compare changes at different stages
- Rename and remove files maintaining history
- Rebase feature branch onto updated main
- Interactive rebase to squash commits
- Stash and apply changes
- Revert problematic commits
- Manage multiple bare remotes

#### Part 3: Advanced Git Operations (Chapters 19-23, 24-32 selected)
**Difficulty:** Advanced
**Duration:** 90-120 minutes

**Topics:**
- Reset modes (soft, mixed, hard)
- Force pushing and history rewriting
- Reflog and commit recovery
- Patch mode (git add -p)
- Cherry-picking commits
- Git blame for code archaeology
- Git configuration (local, global, system)
- Custom aliases
- Amending commits
- Tags (lightweight and annotated)
- Worktrees

**Key Commands:** `git reset`, `git push --force-with-lease`, `git reflog`, `git add -p`, `git reset -p`, `git cherry-pick`, `git blame`, `git config`, `git commit --amend`, `git tag`, `git worktree`

**Hands-On Exercises:**
- Use reset modes to uncommit and recommit
- Handle force push scenarios safely
- Recover "lost" commits using reflog
- Stage partial file changes with patch mode
- Cherry-pick specific commits between branches
- Use blame to investigate code history
- Create useful aliases
- Amend commits
- Create and push tags to remote
- Work with multiple worktrees simultaneously

#### Optional Bonus: GitHub Integration (Chapter 17)
**Difficulty:** Advanced
**Duration:** 30-45 minutes
**Note:** This is GitHub-specific and not core Git

**Topics:**
- GitHub account setup and authentication
- Forking repositories
- Pull request workflows
- Upstream synchronization

**Key Tools:** GitHub CLI (`gh`), SSH keys, Personal Access Tokens

**Hands-On Exercises:**
- Set up GitHub authentication
- Fork a repository
- Create pull requests
- Sync fork with upstream

### Existing Lab Patterns in Codebase

From `/Users/erik/code/instruqt/labs/getting-started/`:

**Modular Chapter Pattern:**
```
getting-started/
├── main.hcl
├── layouts.hcl
├── sandbox.hcl
├── tabs.hcl
├── modules/
│   └── chapters/
│       ├── chapter1/
│       │   ├── pages.hcl
│       │   ├── outputs.hcl
│       │   └── instructions/
│       └── chapter2/
└── modules.hcl
```

**Module declaration:**
```hcl
module "chapter_basics" {
  source = "modules/chapters/basics"
}
```

**Using module outputs:**
```hcl
page "intro" {
  reference = module.chapter_basics.output.pages.intro
}
```

**Key conventions:**
- Lowercase with underscores for resource IDs
- Markdown files in `instructions/` subdirectories
- Shell scripts in `scripts/` for task validation
- `data("name")` for temporary file paths
- `file("path")` to embed file contents

## Recommended Lab Structure

### Three-Lab Series (Recommended)

**Lab 1: Git Fundamentals** (Beginner)
- Based on Beej's Chapters 2-6 (adapted for bare repos)
- Topics: Init, commits, branches, merging, basic remotes
- Duration: 60-90 minutes
- Remote Strategy: Use bare repositories for remote exercises
- Natural endpoint: Students can work with branches, handle conflicts, and push/pull from remotes

**Lab 2: Git Collaboration & History** (Intermediate)
- Based on Beej's Chapters 7-16, 18
- Topics: File management, .gitignore, diff, rebase, stash, revert
- Duration: 90-120 minutes
- Remote Strategy: Multiple bare remotes to simulate team workflows
- Natural endpoint: Students can manipulate history, collaborate effectively, and manage complex workflows

**Lab 3: Advanced Git Operations** (Advanced)
- Based on Beej's Chapters 19-23, selected topics from 24-32
- Topics: Reset, reflog, patch mode, cherry-pick, blame, config, aliases, tags, worktrees
- Duration: 90-120 minutes
- Remote Strategy: Force push scenarios with bare remotes
- Natural endpoint: Complete Git command-line mastery

**Optional Lab 4: GitHub Workflows** (Platform-Specific)
- Based on Beej's Chapter 17
- Topics: GitHub authentication, forking, pull requests
- Duration: 30-45 minutes
- Note: This requires GitHub accounts and authentication setup

### Rationale for Pre-Configured Remotes Over GitHub

**Using pre-configured remotes (backed by bare repos) simplifies learning Git because:**
1. **No authentication overhead** - No SSH keys, PATs, or GitHub CLI setup required
2. **Focus on Git mechanics** - Students learn Git commands, not platform-specific features
3. **Instant setup** - Students start with `origin` already configured, just like a real project
4. **Universal knowledge** - Skills transfer directly to GitHub, GitLab, Bitbucket, or any Git host
5. **Realistic workflow** - Students interact with remotes exactly as they would in the real world
6. **Offline capable** - Everything happens within the lab sandbox
7. **Removes mysticism** - No magic difference between "origin" in the lab vs. "origin" at work

### Rationale for Separate Labs

**Separate labs are preferable because:**
1. **Clear skill progression** - Each lab has a defined difficulty level
2. **Flexible learning paths** - Students can take only what they need
3. **Better completion rates** - Shorter labs are less daunting
4. **Easier maintenance** - Update individual labs without affecting others
5. **Reusable modules** - Advanced labs can reference fundamentals
6. **Natural stopping points** - Each lab provides complete skills for that level

## Implementation Recommendations

### Sandbox Configuration

For all Git labs, use a container-based approach with bare repositories for remote exercises:

```hcl
resource "container" "git_workstation" {
  image {
    name = "ubuntu:22.04"
  }

  network {
    id = resource.network.main.meta.id
  }

  # Pre-install git and configure
  command = ["/bin/bash", "-c", "apt-get update && apt-get install -y git && tail -f /dev/null"]
}
```

**Pre-configuration setup script example:**
```bash
# Configure Git identity
git config --global user.name "Lab Student"
git config --global user.email "student@lab.local"

# Create bare repositories in /opt/git/ (hidden from students)
mkdir -p /opt/git/origin.git
cd /opt/git/origin.git
git init --bare

# Optional: Create additional remotes for team simulation
mkdir -p /opt/git/upstream.git
cd /opt/git/upstream.git
git init --bare

# Pre-clone or pre-configure repositories in student workspace
# so remotes are already set up
cd /root/workspace
git init
git remote add origin /opt/git/origin.git
```

**Key advantages:**
- No external dependencies or authentication
- Fast setup and teardown
- Full control over remote state
- Can simulate multiple remotes easily
- Students interact with remotes naturally, just like GitHub
- **Students never need to know about bare repos initially** - they just work with `origin` like everyone does
- The abstraction is the same whether using GitHub, GitLab, or bare repos

### Task Validation Strategy

**Progressive validation:**
- Early labs: More guided with detailed failure messages
- Later labs: Less hand-holding, more realistic scenarios

**Example check script structure:**
```bash
#!/bin/bash
# scripts/first_commit/check.sh

if [ ! -d .git ]; then
  echo "Not in a git repository"
  exit 1
fi

COMMITS=$(git rev-list --count HEAD 2>/dev/null)
if [ "$COMMITS" -lt 1 ]; then
  echo "No commits found. Create a commit with 'git commit'"
  exit 1
fi

exit 0
```

### Hands-On Exercise Types

**Must-have interactive components:**
1. Creating and resolving merge conflicts
2. Interactive rebase with squashing
3. Detached HEAD exploration and recovery
4. Remote branch management
5. Stash workflow interruptions
6. Reflog-based commit recovery
7. Patch mode partial staging
8. Submodule integration (advanced)
9. Worktree parallel development (advanced)

**Scenario-based exercises:**
- "Your teammate pushed changes while you were working" (pull conflicts)
- "You committed to the wrong branch" (cherry-pick/reset)
- "You need to hotfix while on a feature" (stash)
- "You accidentally reset --hard and lost work" (reflog recovery)
- "You need to share a specific commit with another branch" (cherry-pick)

### Content Adaptation Notes

**From Beej's guide:**
- Chapter 3 (GitHub setup) → Skip authentication entirely, use pre-configured remotes
- Chapter 17 (Forking/PRs) → Move to optional GitHub-specific lab
- Appendix 35 (error messages) → Integrate as contextual help
- Appendix 38 (quick reference) → Provide as downloadable cheat sheet
- Chapter 33 (playground) → Inform lab environment setup
- Chapters 34, 36 (Vim) → Optional, provide basic editor guidance

**Key adaptations for pre-configured remotes:**
- Students see `origin` already configured, just like cloning from GitHub
- **Don't mention bare repositories or filesystem paths in beginner content** - students just use `git push`/`git pull`
- Focus on Git operations, not where the remote lives
- Optional advanced content: "Under the hood - what is origin?" explaining bare repos
- The goal: students learn transferable Git skills, not lab infrastructure

**Additional topics to consider:**
- Git hooks (not deeply covered in guide)
- Git LFS (large file storage)
- Git bisect (binary search for bugs)
- Git internals (.git directory structure)

### Bare Repository Setup (Behind the Scenes)

**Lab setup (done automatically, invisible to students):**
```bash
# Create bare repositories in /opt/git/ (lab infrastructure)
mkdir -p /opt/git/origin.git
git init --bare /opt/git/origin.git

# Student workspace comes pre-configured
cd /root/workspace
git remote -v
# origin  /opt/git/origin.git (fetch)
# origin  /opt/git/origin.git (push)
```

**From student perspective:**
They see `origin` already configured and just use standard Git commands:
```bash
git push origin main
git pull origin main
git fetch origin
```

**Simulating multiple developers (for collaboration labs):**
```bash
# Both "developers" clone from same bare repo (pre-configured)
# Developer 1 workspace: /root/dev1/project
# Developer 2 workspace: /root/dev2/project
# Both point to: /opt/git/project.git

# Students just do normal Git operations
cd /root/dev1/project
# make changes, commit, push

cd /root/dev2/project
# pull changes, see teammate's work, handle conflicts
```

**Simulating upstream/origin pattern (for advanced labs):**
```bash
# Pre-configured by lab setup
git remote -v
# origin    /opt/git/origin.git (fetch)
# origin    /opt/git/origin.git (push)
# upstream  /opt/git/upstream.git (fetch)
# upstream  /opt/git/upstream.git (push)

# Students use standard fork workflow commands
git fetch upstream
git merge upstream/main
```

**Why this approach works well:**
- **Students focus on Git commands, not infrastructure** - they interact with `origin` just like with GitHub
- No confusion about HTTPS vs SSH authentication
- Instant feedback without network latency
- Easy to reset and retry exercises
- **Mimics real-world usage** - most developers never create bare repos, they just use them
- Can optionally explain "what's behind the curtain" in advanced content
- The commands students learn transfer directly to GitHub/GitLab/Bitbucket

## Validation Commands

**Test lab validity:**
```bash
instruqt lab validate /Users/erik/code/instruqt/labs/git
```

**Common validation issues:**
- File paths must exist relative to config file
- Activity IDs must be unique and alphanumeric
- All referenced activities must be defined
- Width/height percentages should total 100%

## Next Steps

1. **Create first lab structure for Lab 1: Git Fundamentals**
   ```bash
   cd /Users/erik/code/instruqt/labs/git
   mkdir -p git-fundamentals/{instructions,scripts,modules/chapters}
   cd git-fundamentals
   ```

2. **Create basic HCL files:**
   - `main.hcl` - Lab resource with chapters on init, commits, branches, merging, remotes
   - `sandbox.hcl` - Container with Git, bare repos pre-configured
   - `layouts.hcl` - Two-column layout with terminal + instructions
   - `pages.hcl` - Page resources for each instructional section

3. **Develop startup script** to pre-configure environment:
   - Install Git
   - Set Git identity
   - Create bare repositories in `/opt/git/`
   - Prepare workspace directories

4. **Build first chapter content** (adapting Beej Ch 2-4):
   - Replace GitHub setup with bare repo setup
   - Show `git init` and basic workflow
   - Introduce bare repos as "the remote"
   - Add validation tasks for each key concept

5. **Test and validate:**
   ```bash
   instruqt lab validate /Users/erik/code/instruqt/labs/git/git-fundamentals
   ```

6. **Iterate on Lab 1**, then proceed to Labs 2 and 3

## Related Research

- Instruqt documentation: https://docs.labs.instruqt.com/
- Beej's Git Guide: https://beej.us/guide/bggit/html/split/
- Existing lab examples: `/Users/erik/code/instruqt/lab-examples/`

## Open Questions

1. Should we include optional "under the hood" content explaining bare repos, or keep it completely hidden?
2. What level of Git internals should be covered (beyond Beej's scope)?
3. Should the optional GitHub lab be included or left as future work?
4. Should advanced labs have prerequisites checking for fundamental skills?
5. How much emphasis on submodules vs worktrees (both are advanced, time-limited)?
6. For collaboration exercises, use multiple directories in same container or multiple containers?
