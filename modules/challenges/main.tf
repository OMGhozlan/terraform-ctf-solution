# ============================================================================
# Challenges Module - Main Configuration
# ============================================================================
# This module contains all CTF challenge implementations
# Flags are NOT defined here - they're revealed by the provider upon success!
# ============================================================================

# Import hint data sources (if enabled)
data "ctfchallenge_hint" "hints" {
  for_each = var.enable_hints ? var.hint_levels : {}

  challenge_id = each.key
  level        = each.value
}