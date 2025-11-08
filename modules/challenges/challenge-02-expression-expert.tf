# ============================================================================
# Challenge 2: Expression Expert
# ============================================================================
# Objective: Master Terraform expressions and functions
# Points: 350
# Difficulty: Intermediate
#
# Task: Compute base64encode(sha256("terraformexpressionsrock"))
# ============================================================================

resource "null_resource" "expression_examples" {
  count = local.challenges_enabled.expression_expert ? 1 : 0

  triggers = {
    final_result = local.expr_step_4_encoded
  }
}

# Submit proof of work - flag will be revealed upon success!
resource "ctfchallenge_flag_validator" "expression_expert" {
  count = local.challenges_enabled.expression_expert ? 1 : 0

  challenge_id = local.challenge_metadata.expression_expert.id

  proof_of_work = {
    computed_value = local.expr_step_4_encoded
  }
}