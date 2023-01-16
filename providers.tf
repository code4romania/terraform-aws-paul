terraform {
  cloud {
    organization = "onghub"

    workspaces {
      tags = [
        "paul",
        "aws"
      ]
    }
  }
}
