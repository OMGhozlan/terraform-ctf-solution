
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