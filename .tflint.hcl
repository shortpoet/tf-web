config {
  module              = true
  disabled_by_default = false
  # varfile             = ["dev.tfvars", "prod.tfvars"]
}

# https://github.com/terraform-linters/tflint-ruleset-azurerm/blob/master/docs/README.md
plugin "azurerm" {
  enabled = false
  version = "0.20.0"
  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}

# https://github.com/terraform-linters/tflint-ruleset-aws/blob/master/docs/configuration.md
# https://github.com/terraform-linters/tflint-ruleset-aws/blob/master/docs/rules/README.md
plugin "aws" {
  enabled = true
  version = "0.21.2"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

# https://github.com/terraform-linters/tflint-ruleset-google/blob/master/docs/rules/README.md
plugin "google" {
  enabled = false
  version = "0.22.2"
  source  = "github.com/terraform-linters/tflint-ruleset-google"
}
# Disallow // comments in favor of #.
rule "terraform_comment_syntax" {
  enabled = true
}

# Disallow legacy dot index syntax.
rule "terraform_deprecated_index" {
  enabled = true
}

# Disallow deprecated (0.11-style) interpolation
rule "terraform_deprecated_interpolation" {
  enabled = true
}

# Disallow output declarations without description.
rule "terraform_documented_outputs" {
  enabled = false
}

# Disallow variable declarations without description.
rule "terraform_documented_variables" {
  enabled = true
}

# Disallow specifying a git or mercurial repository as a module source without pinning to a version.
rule "terraform_module_pinned_source" {
  # TODO - enable this rule
  enabled = false
}

rule "terraform_module_version" {
  enabled = true
  exact   = false # default
}

# Require that all providers have version constraints through required_providers.
rule "terraform_required_providers" {
  enabled = true
}

# Disallow terraform declarations without require_version.
rule "terraform_required_version" {
  enabled = true
}

# Ensure that a module complies with the Terraform Standard Module Structure
rule "terraform_standard_module_structure" {
  enabled = false
}

# Disallow variable declarations without type.
rule "terraform_typed_variables" {
  enabled = true
}

# Disallow variables, data sources, and locals that are declared but never used.
rule "terraform_unused_declarations" {
  enabled = true
}

rule "terraform_unused_required_providers" {
  enabled = true
}

# terraform.workspace should not be used with a "remote" backend with remote execution.
rule "terraform_workspace_remote" {
  enabled = true
}

# Enforces naming conventions
rule "terraform_naming_convention" {
  enabled = true

  #Require specific naming structure
  variable {
    format = "snake_case"
  }

  locals {
    format = "snake_case"
  }

  output {
    format = "snake_case"
  }

  #Allow any format
  resource {
    format = "none"
  }

  module {
    format = "none"
  }

  data {
    format = "none"
  }
}
