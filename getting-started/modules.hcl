module "chapter_chapters" {
  source = "modules/chapters/chapters"
}

module "chapter_configuration_basics" {
  source = "modules/chapters/configuration_basics"
}

module "chapter_create_lab" {
  source = "modules/chapters/create_lab"
}

module "chapter_finish" {
  source = "modules/chapters/finish"
}

module "chapter_instruqt_cli" {
  source = "modules/chapters/instruqt_cli"
}

module "chapter_quizzes" {
  source = "modules/chapters/quizzes"
}

module "chapter_sandbox" {
  source = "modules/chapters/sandbox"
}

module "chapter_tasks" {
  source = "modules/chapters/tasks"
}

module "chapter_version_control" {
  source = "modules/chapters/version_control"
}
