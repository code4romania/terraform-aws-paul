terraform {
  cloud {
    organization = "code4romania"

    workspaces {
      tags = [
        "paul",
        "aws"
      ]
    }
  }
}
