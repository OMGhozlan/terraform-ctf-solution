# ============================================================================
# Challenge 6: For-Each Wizard
# ============================================================================
# Objective: Use for_each to manage multiple resources elegantly
# Points: 250
# Difficulty: Intermediate
#
# Task: Create resources using for_each with: alpha, beta, gamma, delta
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

# Submit proof of work - flag will be revealed upon success!
resource "ctfchallenge_flag_validator" "foreach_wizard" {
  count = local.challenges_enabled.for_each_wizard ? 1 : 0

  challenge_id = local.challenge_metadata.for_each_wizard.id

  proof_of_work = {
    items = join(",", sort(local.greek_letters))
  }

  depends_on = [null_resource.greek_letters]
}