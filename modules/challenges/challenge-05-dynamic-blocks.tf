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