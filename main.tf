# ============================================================================
# CTF Challenge Solutions - Main Configuration
# ============================================================================

# Provider Configuration
provider "ctfchallenge" {
  player_name = var.player_name
}

provider "null" {}
provider "random" {}

# ============================================================================
# Challenge Information Data Sources
# ============================================================================

data "ctfchallenge_list" "all_challenges" {}

# ============================================================================
# Call Challenges Module
# ============================================================================

module "challenges" {
  source = "./modules/challenges"

  challenges_enabled = local.challenges_enabled
  challenge_metadata = local.challenge_metadata
  common_tags        = local.common_tags
  enable_hints       = var.enable_hints
  hint_levels        = var.hint_levels
}

# ============================================================================
# Call Puzzles Module
# ============================================================================

module "puzzles" {
  source = "./modules/puzzles"

  xor_solution = local.xor_puzzle_solution
}