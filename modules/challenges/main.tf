# Import hint data sources
data "ctfchallenge_hint" "hints" {
  for_each = var.enable_hints ? var.hint_levels : {}

  challenge_id = each.key
  level        = each.value
}