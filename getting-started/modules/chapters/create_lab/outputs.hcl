output "pages" {
  value = {
    "create_lab" = resource.page.create_lab
    "create_repository" = resource.page.create_repository
    "initial_push" = resource.page.initial_push
  }
}
