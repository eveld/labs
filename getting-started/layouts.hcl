resource "layout" "single_column" {
  column "instructions" {}
}

resource "layout" "split_screen" {
  column "hands_on" {
    width = "60%"
  }

  column "instructions" {}
}