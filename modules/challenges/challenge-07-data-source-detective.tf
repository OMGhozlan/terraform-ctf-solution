# ============================================================================
# Challenge 7: Data Source Detective
# ============================================================================
# Objective: Query and filter data sources effectively
# Points: 150
# Difficulty: Beginner
#
# Task: Find the correct filtered count (hint: it's 7)
# ============================================================================

data "ctfchallenge_list" "filtered_by_difficulty" {
  count = local.challenges_enabled.data_source_detective ? 1 : 0

  difficulty = "beginner"
}

# Submit proof of work - flag will be revealed upon success!
resource "ctfchallenge_flag_validator" "data_source_detective" {
  count = local.challenges_enabled.data_source_detective ? 1 : 0

  challenge_id = local.challenge_metadata.data_source_detective.id

  proof_of_work = {
    filtered_count = tostring(local.filtered_count)
  }
}