output "challenge_results" {
  description = "Detailed results for each challenge"
  value = {
    terraform_basics = local.challenges_enabled.terraform_basics ? {
      validated = try(ctfchallenge_flag_validator.terraform_basics[0].validated, false)
      points    = try(ctfchallenge_flag_validator.terraform_basics[0].points, 0)
      message   = try(ctfchallenge_flag_validator.terraform_basics[0].message, "Not attempted")
    } : { enabled = false }

    expression_expert = local.challenges_enabled.expression_expert ? {
      validated = try(ctfchallenge_flag_validator.expression_expert[0].validated, false)
      points    = try(ctfchallenge_flag_validator.expression_expert[0].points, 0)
      message   = try(ctfchallenge_flag_validator.expression_expert[0].message, "Not attempted")
    } : { enabled = false }

    state_secrets = local.challenges_enabled.state_secrets ? {
      validated = try(ctfchallenge_flag_validator.state_secrets[0].validated, false)
      points    = try(ctfchallenge_flag_validator.state_secrets[0].points, 0)
      message   = try(ctfchallenge_flag_validator.state_secrets[0].message, "Not attempted")
    } : { enabled = false }

    module_master = local.challenges_enabled.module_master ? {
      validated = try(ctfchallenge_flag_validator.module_master[0].validated, false)
      points    = try(ctfchallenge_flag_validator.module_master[0].points, 0)
      message   = try(ctfchallenge_flag_validator.module_master[0].message, "Not attempted")
    } : { enabled = false }

    dynamic_blocks = local.challenges_enabled.dynamic_blocks ? {
      validated = try(ctfchallenge_flag_validator.dynamic_blocks[0].validated, false)
      points    = try(ctfchallenge_flag_validator.dynamic_blocks[0].points, 0)
      message   = try(ctfchallenge_flag_validator.dynamic_blocks[0].message, "Not attempted")
    } : { enabled = false }

    for_each_wizard = local.challenges_enabled.for_each_wizard ? {
      validated = try(ctfchallenge_flag_validator.foreach_wizard[0].validated, false)
      points    = try(ctfchallenge_flag_validator.foreach_wizard[0].points, 0)
      message   = try(ctfchallenge_flag_validator.foreach_wizard[0].message, "Not attempted")
    } : { enabled = false }

    data_source_detective = local.challenges_enabled.data_source_detective ? {
      validated = try(ctfchallenge_flag_validator.data_source_detective[0].validated, false)
      points    = try(ctfchallenge_flag_validator.data_source_detective[0].points, 0)
      message   = try(ctfchallenge_flag_validator.data_source_detective[0].message, "Not attempted")
    } : { enabled = false }

    cryptographic_compute = local.challenges_enabled.cryptographic_compute ? {
      validated = try(ctfchallenge_flag_validator.cryptographic_compute[0].validated, false)
      points    = try(ctfchallenge_flag_validator.cryptographic_compute[0].points, 0)
      message   = try(ctfchallenge_flag_validator.cryptographic_compute[0].message, "Not attempted")
    } : { enabled = false }
  }
}

output "total_points_earned" {
  value = sum([
    local.challenges_enabled.terraform_basics ? try(ctfchallenge_flag_validator.terraform_basics[0].points, 0) : 0,
    local.challenges_enabled.expression_expert ? try(ctfchallenge_flag_validator.expression_expert[0].points, 0) : 0,
    local.challenges_enabled.state_secrets ? try(ctfchallenge_flag_validator.state_secrets[0].points, 0) : 0,
    local.challenges_enabled.module_master ? try(ctfchallenge_flag_validator.module_master[0].points, 0) : 0,
    local.challenges_enabled.dynamic_blocks ? try(ctfchallenge_flag_validator.dynamic_blocks[0].points, 0) : 0,
    local.challenges_enabled.for_each_wizard ? try(ctfchallenge_flag_validator.foreach_wizard[0].points, 0) : 0,
    local.challenges_enabled.data_source_detective ? try(ctfchallenge_flag_validator.data_source_detective[0].points, 0) : 0,
    local.challenges_enabled.cryptographic_compute ? try(ctfchallenge_flag_validator.cryptographic_compute[0].points, 0) : 0,
  ])
}

output "challenges_completed_count" {
  value = length([
    for validator in [
      try(ctfchallenge_flag_validator.terraform_basics[0], null),
      try(ctfchallenge_flag_validator.expression_expert[0], null),
      try(ctfchallenge_flag_validator.state_secrets[0], null),
      try(ctfchallenge_flag_validator.module_master[0], null),
      try(ctfchallenge_flag_validator.dynamic_blocks[0], null),
      try(ctfchallenge_flag_validator.foreach_wizard[0], null),
      try(ctfchallenge_flag_validator.data_source_detective[0], null),
      try(ctfchallenge_flag_validator.cryptographic_compute[0], null),
    ] : validator if validator != null && try(validator.validated, false)
  ])
}

output "hints" {
  value = {
    for challenge_id, hint in data.ctfchallenge_hint.hints :
    challenge_id => hint.hint
  }
}

output "expression_computation_steps" {
  value = local.challenges_enabled.expression_expert ? {
    step_1_strings = local.expr_step_1_strings
    step_2_joined  = local.expr_step_2_joined
    step_3_hashed  = local.expr_step_3_hashed
    step_4_encoded = local.expr_step_4_encoded
  } : null
}

output "state_secrets_info" {
  value = local.challenges_enabled.state_secrets ? {
    magic_number      = local.magic_number
    resources_created = length(null_resource.state_tracking)
  } : null
}

output "module_master_info" {
  value = local.challenges_enabled.module_master ? {
    vpc_id          = module.network_example[0].vpc_id
    subnet_ids      = module.network_example[0].subnet_ids
    network_summary = module.network_example[0].network_summary
  } : null
}

output "dynamic_blocks_info" {
  value = local.challenges_enabled.dynamic_blocks ? {
    port_configs        = local.port_configs
    dynamic_block_count = local.dynamic_block_count
  } : null
}

output "foreach_wizard_info" {
  value = local.challenges_enabled.for_each_wizard ? {
    greek_letters = local.greek_letters
    metadata      = local.greek_metadata
  } : null
}

output "data_source_detective_info" {
  value = local.challenges_enabled.data_source_detective ? {
    total_items         = length(local.infrastructure_items)
    filtered_count      = local.filtered_count
    active_prod_servers = keys(local.active_prod_servers)
  } : null
}

output "cryptographic_compute_info" {
  value = local.challenges_enabled.cryptographic_compute ? {
    secret_input     = local.crypto_secret
    step_2_sha256    = local.crypto_step_2_sha256
    step_3_final_md5 = local.crypto_final_hash
  } : null
}