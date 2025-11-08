# ============================================================================
# Challenge 1: Terraform Basics
# ============================================================================

resource "null_resource" "step_1_foundation" {
  count = local.challenges_enabled.terraform_basics ? 1 : 0

  triggers = {
    timestamp = timestamp()
    step      = "foundation"
    order     = 1
  }
}

resource "null_resource" "step_2_framework" {
  count      = local.challenges_enabled.terraform_basics ? 1 : 0
  depends_on = [null_resource.step_1_foundation]

  triggers = {
    timestamp = timestamp()
    step      = "framework"
    order     = 2
  }
}

resource "null_resource" "step_3_completion" {
  count      = local.challenges_enabled.terraform_basics ? 1 : 0
  depends_on = [null_resource.step_2_framework]

  triggers = {
    timestamp = timestamp()
    step      = "completion"
    order     = 3
  }
}

resource "ctfchallenge_flag_validator" "terraform_basics" {
  count = local.challenges_enabled.terraform_basics ? 1 : 0

  challenge_id = local.challenge_metadata.terraform_basics.id
  flag         = local.challenge_metadata.terraform_basics.flag

  proof_of_work = {
    dependencies = join(",", [
      null_resource.step_1_foundation[0].id,
      null_resource.step_2_framework[0].id,
      null_resource.step_3_completion[0].id,
    ])
  }
}

# ============================================================================
# Challenge 2: Expression Expert
# ============================================================================

resource "null_resource" "expression_examples" {
  count = local.challenges_enabled.expression_expert ? 1 : 0

  triggers = {
    final_result = local.expr_step_4_encoded
  }
}

resource "ctfchallenge_flag_validator" "expression_expert" {
  count = local.challenges_enabled.expression_expert ? 1 : 0

  challenge_id = local.challenge_metadata.expression_expert.id
  flag         = local.challenge_metadata.expression_expert.flag

  proof_of_work = {
    computed_value = local.expr_step_4_encoded
  }
}

# ============================================================================
# Challenge 3: State Secrets
# ============================================================================

resource "random_integer" "state_example" {
  count = local.challenges_enabled.state_secrets ? 1 : 0

  min = 1
  max = local.magic_number

  keepers = {
    purpose      = "Demonstrate state persistence"
    magic_number = local.magic_number
  }
}

resource "null_resource" "state_tracking" {
  count = local.challenges_enabled.state_secrets ? local.magic_number : 0

  triggers = {
    index       = count.index
    total_count = local.magic_number
  }
}

resource "ctfchallenge_flag_validator" "state_secrets" {
  count = local.challenges_enabled.state_secrets ? 1 : 0

  challenge_id = local.challenge_metadata.state_secrets.id
  flag         = local.challenge_metadata.state_secrets.flag

  proof_of_work = {
    resource_count = tostring(local.magic_number)
  }

  depends_on = [null_resource.state_tracking]
}

# ============================================================================
# Challenge 4: Module Master
# ============================================================================

module "network_example" {
  count = local.challenges_enabled.module_master ? 1 : 0

  source = "../network-example"

  environment  = "ctf-challenge"
  vpc_cidr     = "10.0.0.0/16"
  subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  tags = merge(local.common_tags, {
    Challenge = "Module Master"
  })
}

resource "null_resource" "module_consumer" {
  count = local.challenges_enabled.module_master ? 1 : 0

  triggers = {
    vpc_id           = module.network_example[0].vpc_id
    module_reference = "module.network_example[0].vpc_id = ${module.network_example[0].vpc_id}"
  }
}

resource "ctfchallenge_flag_validator" "module_master" {
  count = local.challenges_enabled.module_master ? 1 : 0

  challenge_id = local.challenge_metadata.module_master.id
  flag         = local.challenge_metadata.module_master.flag

  proof_of_work = {
    module_output = "module.network_example[0].vpc_id = ${module.network_example[0].vpc_id}"
  }

  depends_on = [module.network_example]
}

# ============================================================================
# Challenge 5: Dynamic Blocks
# ============================================================================

resource "null_resource" "dynamic_blocks_demo" {
  count = local.challenges_enabled.dynamic_blocks ? 1 : 0

  triggers = merge(
    { dynamic_count = local.dynamic_block_count },
    {
      for name, config in local.port_configs :
      "rule_${name}" => jsonencode(config)
    }
  )
}

resource "null_resource" "port_rules" {
  for_each = local.challenges_enabled.dynamic_blocks ? local.port_configs : {}

  triggers = {
    rule_name = each.key
    port      = each.value.port
    protocol  = each.value.protocol
  }
}

resource "ctfchallenge_flag_validator" "dynamic_blocks" {
  count = local.challenges_enabled.dynamic_blocks ? 1 : 0

  challenge_id = local.challenge_metadata.dynamic_blocks.id
  flag         = local.challenge_metadata.dynamic_blocks.flag

  proof_of_work = {
    dynamic_block_count = tostring(local.dynamic_block_count)
  }

  depends_on = [null_resource.port_rules]
}

# ============================================================================
# Challenge 6: For-Each Wizard
# ============================================================================

resource "null_resource" "greek_letters" {
  for_each = local.challenges_enabled.for_each_wizard ? local.greek_letters : []

  triggers = {
    name = each.key
  }
}

resource "random_integer" "greek_values" {
  for_each = local.challenges_enabled.for_each_wizard ? local.greek_metadata : {}

  min = each.value.order * 10
  max = each.value.order * 100

  keepers = {
    letter = each.key
  }
}

resource "ctfchallenge_flag_validator" "foreach_wizard" {
  count = local.challenges_enabled.for_each_wizard ? 1 : 0

  challenge_id = local.challenge_metadata.for_each_wizard.id
  flag         = local.challenge_metadata.for_each_wizard.flag

  proof_of_work = {
    items = join(",", sort(local.greek_letters))
  }

  depends_on = [null_resource.greek_letters]
}

# ============================================================================
# Challenge 7: Data Source Detective
# ============================================================================

data "ctfchallenge_list" "filtered_by_difficulty" {
  count = local.challenges_enabled.data_source_detective ? 1 : 0

  difficulty = "beginner"
}

resource "ctfchallenge_flag_validator" "data_source_detective" {
  count = local.challenges_enabled.data_source_detective ? 1 : 0

  challenge_id = local.challenge_metadata.data_source_detective.id
  flag         = local.challenge_metadata.data_source_detective.flag

  proof_of_work = {
    filtered_count = tostring(local.filtered_count)
  }
}

# ============================================================================
# Challenge 8: Cryptographic Compute
# ============================================================================

resource "null_resource" "crypto_operations" {
  count = local.challenges_enabled.cryptographic_compute ? 1 : 0

  triggers = {
    final_hash = local.crypto_final_hash
  }
}

resource "ctfchallenge_flag_validator" "cryptographic_compute" {
  count = local.challenges_enabled.cryptographic_compute ? 1 : 0

  challenge_id = local.challenge_metadata.cryptographic_compute.id
  flag         = local.challenge_metadata.cryptographic_compute.flag

  proof_of_work = {
    crypto_hash = local.crypto_final_hash
  }

  depends_on = [null_resource.crypto_operations]
}