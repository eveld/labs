resource "lab" "getting_started" {
  title = "Getting Started"
  description = "This lab teaches you how to get started using the new Instruqt Labs."

  layout "single_column" {
    default = true
    reference = resource.layout.single_column

    instructions {
      panel = "instructions"
    }
  }

  layout "split_screen" {
    reference = resource.layout.split_screen

    instructions {
      panel = "instructions"
    }
  }

  content {
    chapter "version_control" {
      title = "Setting up Version Control"
      layout_name = "single_column"
      
      page "configure_git" {
        reference = module.chapter_version_control.output.pages.configure_git
      }

      page "configure_github" {
        reference = module.chapter_version_control.output.pages.configure_github
      }

      page "github_integration" {
        reference = module.chapter_version_control.output.pages.github_integration
      }
    }


    chapter "instruqt_cli" {
      title = "Install Instruqt CLI"
      layout_name = "single_column"
      
      page "instruqt_cli" {
        reference = module.chapter_instruqt_cli.output.pages.github_integration
      }
    }

    chapter "create_lab" {
      title = "Creating your first lab"

      page "create_lab" {
        reference = module.chapter_create_lab.output.pages.create_lab
      }

      page "create_repository" {
        reference = module.chapter_create_lab.output.pages.create_repository
      }

      page "push_lab" {
        reference = module.chapter_create_lab.output.pages.initial_push
      }

      page "import_lab" {
        reference = module.chapter_create_lab.output.pages.import_lab
      }
    }

    chapter "configuration_basics" {
      title = "Configuration Basics"

      page "introduction" {
        reference = module.chapter_configuration_basics.output.pages.introduction
      }

      page "explore_configuration" {
        reference = module.chapter_configuration_basics.output.pages.explore_configuration
      }

      page "make_changes" {
        reference = module.chapter_configuration_basics.output.pages.make_changes
      }
    }

    chapter "chapters" {
      title = "Adding your first chapter"

      page "create_outline" {
        reference = module.chapter_chapters.output.pages.create_outline
      }

      page "add_page" {
        reference = module.chapter_chapters.output.pages.add_page
      }

      page "display_instructions" {
        reference = module.chapter_chapters.output.pages.display_instructions
      }
    }

    chapter "sandbox" {
      title = "Configuring sandboxes"

      page "add_resources" {
        reference = module.chapter_sandbox.output.pages.add_resources
      }

      page "add_tab" {
        reference = module.chapter_sandbox.output.pages.add_tab
      }

      page "customize_layout" {
        reference = module.chapter_sandbox.output.pages.customize_layout
      }
    }

    chapter "quizzes" {
      title = "Adding quizzes"

      page "add_questions" {
        reference = module.chapter_quizzes.output.pages.add_questions
      }

      page "add_quiz" {
        reference = module.chapter_quizzes.output.pages.add_quiz
      }

      page "embed_quiz" {
        reference = module.chapter_quizzes.output.pages.embed_quiz
      }

      page "add_page" {
        reference = module.chapter_quizzes.output.pages.add_page
      }
    }

    chapter "tasks" {
      title = "Adding tasks and gating content"

      page "add_task" {
        reference = module.chapter_tasks.output.pages.add_task
      }

      page "lifecycle_hooks" {
        reference = module.chapter_tasks.output.pages.lifecycle_hooks
      }

      page "add_scripts" {
        reference = module.chapter_tasks.output.pages.add_scripts
      }

      page "embed_task" {
        reference = module.chapter_tasks.output.pages.embed_task
      }

      page "add_tab" {
        reference = module.chapter_tasks.output.pages.add_tab
      }

      page "add_page" {
        reference = module.chapter_tasks.output.pages.add_page
      }
    }

    chapter "finish" {
      title = "Finishing up"

      page "feedback" {
        reference = module.chapter_finish.output.pages.feedback
      }

      page "completion" {
          reference = module.chapter_finish.output.pages.completion
      }
    }
  }
}