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