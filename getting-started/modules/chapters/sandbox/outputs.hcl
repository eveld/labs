output "pages" {
  value = {
    "configure_git" = resource.page.configure_git
    "configure_github" = resource.page.configure_github
    "github_integration" = resource.page.github_integration
  }
}
