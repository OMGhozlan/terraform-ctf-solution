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