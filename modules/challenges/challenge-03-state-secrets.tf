# ============================================================================
# Challenge 3: State Secrets
# ============================================================================
# Objective: Understand Terraform state management
# Points: 200
# Difficulty: Beginner
#
# Task: Find the magic number (hint: Douglas Adams)
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

# Submit proof of work - flag will be revealed upon success!
resource "ctfchallenge_flag_validator" "state_secrets" {
  count = local.challenges_enabled.state_secrets ? 1 : 0

  challenge_id = local.challenge_metadata.state_secrets.id

  proof_of_work = {
    resource_count = tostring(local.magic_number)
  }

  depends_on = [null_resource.state_tracking]
}