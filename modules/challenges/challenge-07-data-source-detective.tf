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
