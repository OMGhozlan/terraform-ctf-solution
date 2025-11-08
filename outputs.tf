# Calculate totals based on enabled challenges only
locals {
  # Count enabled challenges
  enabled_challenge_count = length([
    for k, v in local.challenges_enabled : k if v == true
  ])

  # Calculate total possible points from enabled challenges only
  total_possible_points_enabled = sum([
    for challenge_id, enabled in local.challenges_enabled :
    enabled ? local.challenge_metadata[challenge_id].points : 0
  ])
}

# Full summary (sensitive because it contains challenge details)
output "summary" {
  description = "Overall CTF challenge summary"
  sensitive   = true
  value = {
    player_name                = var.player_name
    total_possible             = local.total_possible_points_enabled
    total_earned               = module.challenges.total_points_earned
    challenges_enabled_count   = local.enabled_challenge_count
    challenges_completed_count = module.challenges.challenges_completed_count
    puzzle_solved              = module.puzzles.xor_puzzle_solved
  }
}

# Public summary (non-sensitive, safe to display)
output "public_summary" {
  sensitive   = true
  description = "Public summary of CTF progress (non-sensitive)"
  value = {
    player_name           = var.player_name
    total_possible        = local.total_possible_points_enabled
    total_earned          = module.challenges.total_points_earned
    remaining_points      = local.total_possible_points_enabled - module.challenges.total_points_earned
    challenges_enabled    = local.enabled_challenge_count
    challenges_completed  = module.challenges.challenges_completed_count
    challenges_remaining  = local.enabled_challenge_count - module.challenges.challenges_completed_count
    completion_percentage = local.enabled_challenge_count > 0 ? format("%.1f%%", (module.challenges.challenges_completed_count / tonumber(local.enabled_challenge_count)) * 100) : "N/A"
    puzzle_solved         = module.puzzles.xor_puzzle_solved
  }
}

output "challenge_results" {
  description = "Detailed results for each challenge"
  sensitive   = true
  value       = module.challenges.challenge_results
}

output "available_challenges" {
  description = "List of all available challenges"
  value       = data.ctfchallenge_list.all_challenges.challenges
}

output "hints" {
  description = "Requested hints for challenges"
  value       = var.enable_hints ? module.challenges.hints : {}
}

output "puzzle_results" {
  description = "Results from bonus puzzles"
  value = {
    xor_puzzle = {
      solved  = module.puzzles.xor_puzzle_solved
      message = module.puzzles.xor_puzzle_message
    }
  }
}

output "secret_flags" {
  description = "Secret flags obtained from puzzles"
  sensitive   = true
  value = {
    xor_puzzle = module.puzzles.xor_puzzle_secret
  }
}

# Completion percentage (non-sensitive, dynamic based on enabled challenges)
output "completion_percentage" {
  description = "Percentage of enabled challenges completed"
  sensitive   = true
  value = local.enabled_challenge_count > 0 ? format(
    "%.1f%%",
    (module.challenges.challenges_completed_count / tonumber(local.enabled_challenge_count)) * 100
  ) : "No challenges enabled"
}

# Progress bar visualization (dynamic based on enabled challenges)
output "progress_bar" {
  description = "Visual progress bar for enabled challenges"
  sensitive   = true
  value = local.enabled_challenge_count > 0 ? format(
    "[%s%s] %d/%d challenges - %s",
    join("", [for i in range(module.challenges.challenges_completed_count) : "█"]),
    join("", [for i in range(local.enabled_challenge_count - module.challenges.challenges_completed_count) : "░"]),
    module.challenges.challenges_completed_count,
    local.enabled_challenge_count,
    format("%.1f%%", (module.challenges.challenges_completed_count / tonumber(local.enabled_challenge_count)) * 100)
  ) : "No challenges enabled"
}

# Detailed challenge outputs (non-sensitive)
output "expression_computation_steps" {
  description = "Step-by-step computation for Expression Expert challenge"
  value       = module.challenges.expression_computation_steps
}

output "state_secrets_info" {
  value = module.challenges.state_secrets_info
}

output "module_master_info" {
  value = module.challenges.module_master_info
}

output "dynamic_blocks_info" {
  value = module.challenges.dynamic_blocks_info
}

output "foreach_wizard_info" {
  value = module.challenges.foreach_wizard_info
}

output "data_source_detective_info" {
  value = module.challenges.data_source_detective_info
}

output "cryptographic_compute_info" {
  value = module.challenges.cryptographic_compute_info
}

output "xor_puzzle_info" {
  value = module.puzzles.xor_puzzle_info
}

# Score breakdown (non-sensitive, dynamic based on enabled challenges)
output "score_breakdown" {
  description = "Points breakdown by difficulty (enabled challenges only)"
  value = {
    total_possible = local.total_possible_points_enabled
    total_earned   = module.challenges.total_points_earned
    remaining      = local.total_possible_points_enabled - module.challenges.total_points_earned

    by_difficulty = {
      beginner = {
        possible_if_all_enabled = 450
        enabled_challenges = [
          for id in ["terraform_basics", "state_secrets", "data_source_detective"] :
          "${local.challenge_metadata[id].name} (${local.challenge_metadata[id].points})"
          if local.challenges_enabled[id]
        ]
        total_possible = sum([
          for id in ["terraform_basics", "state_secrets", "data_source_detective"] :
          local.challenges_enabled[id] ? local.challenge_metadata[id].points : 0
        ])
      }
      intermediate = {
        possible_if_all_enabled = 900
        enabled_challenges = [
          for id in ["expression_expert", "dynamic_blocks", "for_each_wizard"] :
          "${local.challenge_metadata[id].name} (${local.challenge_metadata[id].points})"
          if local.challenges_enabled[id]
        ]
        total_possible = sum([
          for id in ["expression_expert", "dynamic_blocks", "for_each_wizard"] :
          local.challenges_enabled[id] ? local.challenge_metadata[id].points : 0
        ])
      }
      advanced = {
        possible_if_all_enabled = 900
        enabled_challenges = [
          for id in ["module_master", "cryptographic_compute"] :
          "${local.challenge_metadata[id].name} (${local.challenge_metadata[id].points})"
          if local.challenges_enabled[id]
        ]
        total_possible = sum([
          for id in ["module_master", "cryptographic_compute"] :
          local.challenges_enabled[id] ? local.challenge_metadata[id].points : 0
        ])
      }
    }
  }
}

# Challenge status (non-sensitive, shows only enabled challenges)
output "challenge_status" {
  description = "Status of enabled challenges"
  value = {
    for challenge_id, enabled in local.challenges_enabled :
    challenge_id => {
      enabled   = enabled
      completed = enabled ? try(module.challenges.challenge_results[challenge_id].validated, false) : null
      points    = enabled ? local.challenge_metadata[challenge_id].points : null
      earned    = enabled ? try(module.challenges.challenge_results[challenge_id].points, 0) : null
    }
  }
}

# Enabled challenges list
output "enabled_challenges" {
  description = "List of currently enabled challenges"
  value = [
    for challenge_id, enabled in local.challenges_enabled :
    {
      id         = challenge_id
      name       = local.challenge_metadata[challenge_id].name
      points     = local.challenge_metadata[challenge_id].points
      difficulty = local.challenge_metadata[challenge_id].difficulty
      category   = local.challenge_metadata[challenge_id].category
      completed  = try(module.challenges.challenge_results[challenge_id].validated, false)
    }
    if enabled
  ]
}

# Disabled challenges list
output "disabled_challenges" {
  description = "List of currently disabled challenges"
  value = [
    for challenge_id, enabled in local.challenges_enabled :
    {
      id         = challenge_id
      name       = local.challenge_metadata[challenge_id].name
      points     = local.challenge_metadata[challenge_id].points
      difficulty = local.challenge_metadata[challenge_id].difficulty
    }
    if !enabled
  ]
}

# Statistics
output "statistics" {
  description = "Detailed statistics"
  sensitive   = true
  value = {
    challenges = {
      total_available = 8
      enabled         = local.enabled_challenge_count
      disabled        = 8 - local.enabled_challenge_count
      completed       = module.challenges.challenges_completed_count
      remaining       = local.enabled_challenge_count - module.challenges.challenges_completed_count
    }
    points = {
      maximum_possible_all = local.total_possible_points
      possible_enabled     = local.total_possible_points_enabled
      earned               = module.challenges.total_points_earned
      remaining            = local.total_possible_points_enabled - module.challenges.total_points_earned
      percentage           = local.total_possible_points_enabled > 0 ? format("%.1f%%", (module.challenges.total_points_earned / tonumber(local.total_possible_points_enabled)) * 100) : "N/A"
    }
    by_difficulty = {
      beginner = {
        enabled   = length([for id in ["terraform_basics", "state_secrets", "data_source_detective"] : id if local.challenges_enabled[id]])
        completed = length([for id in ["terraform_basics", "state_secrets", "data_source_detective"] : id if local.challenges_enabled[id] && try(module.challenges.challenge_results[id].validated, false)])
      }
      intermediate = {
        enabled   = length([for id in ["expression_expert", "dynamic_blocks", "for_each_wizard"] : id if local.challenges_enabled[id]])
        completed = length([for id in ["expression_expert", "dynamic_blocks", "for_each_wizard"] : id if local.challenges_enabled[id] && try(module.challenges.challenge_results[id].validated, false)])
      }
      advanced = {
        enabled   = length([for id in ["module_master", "cryptographic_compute"] : id if local.challenges_enabled[id]])
        completed = length([for id in ["module_master", "cryptographic_compute"] : id if local.challenges_enabled[id] && try(module.challenges.challenge_results[id].validated, false)])
      }
    }
  }
}