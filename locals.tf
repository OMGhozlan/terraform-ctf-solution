locals {
  # Challenge configuration
  challenges_enabled = {
    terraform_basics      = try(var.enable_challenges.terraform_basics, true)
    expression_expert     = try(var.enable_challenges.expression_expert, true)
    state_secrets         = try(var.enable_challenges.state_secrets, true)
    module_master         = try(var.enable_challenges.module_master, true)
    dynamic_blocks        = try(var.enable_challenges.dynamic_blocks, true)
    for_each_wizard       = try(var.enable_challenges.for_each_wizard, true)
    data_source_detective = try(var.enable_challenges.data_source_detective, true)
    cryptographic_compute = try(var.enable_challenges.cryptographic_compute, true)
  }

  # Common metadata
  common_tags = merge(
    var.tags,
    {
      Player = var.player_name
    }
  )

  # Challenge metadata
  challenge_metadata = {
    terraform_basics = {
      id         = "terraform_basics"
      name       = "Terraform Basics"
      flag       = "flag{t3rr4f0rm_d3p3nd3nc13s}"
      points     = 100
      difficulty = "beginner"
      category   = "fundamentals"
    }
    expression_expert = {
      id         = "expression_expert"
      name       = "Expression Expert"
      flag       = "flag{3xpr3ss10ns_unl0ck3d}"
      points     = 350
      difficulty = "intermediate"
      category   = "expressions"
    }
    state_secrets = {
      id         = "state_secrets"
      name       = "State Secrets"
      flag       = "flag{st4t3_m4n4g3m3nt_m4st3r}"
      points     = 200
      difficulty = "beginner"
      category   = "state"
    }
    module_master = {
      id         = "module_master"
      name       = "Module Master"
      flag       = "flag{m0dul3_c0mp0s1t10n_pr0}"
      points     = 400
      difficulty = "advanced"
      category   = "modules"
    }
    dynamic_blocks = {
      id         = "dynamic_blocks"
      name       = "Dynamic Blocks"
      flag       = "flag{dyn4m1c_bl0cks_r0ck}"
      points     = 300
      difficulty = "intermediate"
      category   = "advanced-syntax"
    }
    for_each_wizard = {
      id         = "for_each_wizard"
      name       = "For-Each Wizard"
      flag       = "flag{f0r_34ch_1s_p0w3rful}"
      points     = 250
      difficulty = "intermediate"
      category   = "loops"
    }
    data_source_detective = {
      id         = "data_source_detective"
      name       = "Data Source Detective"
      flag       = "flag{d4t4_s0urc3_sl3uth}"
      points     = 150
      difficulty = "beginner"
      category   = "data-sources"
    }
    cryptographic_compute = {
      id         = "cryptographic_compute"
      name       = "Cryptographic Compute"
      flag       = "flag{crypt0_func_m4st3r}"
      points     = 500
      difficulty = "advanced"
      category   = "functions"
    }
  }

  # Calculate total possible points
  total_possible_points = sum([
    for challenge in local.challenge_metadata :
    challenge.points
  ])

  # XOR puzzle solution
  xor_puzzle_solution = {
    input_1 = "15"
    input_2 = "23"
    input_3 = "42"
    input_4 = "37"
    input_5 = "11"
  }
}