# ============================================================================
# Puzzle Outputs
# ============================================================================

output "xor_puzzle_solved" {
  description = "Whether the XOR puzzle was solved"
  value       = try(ctfchallenge_puzzle_box.xor_puzzle.solved, false)
}

output "xor_puzzle_message" {
  description = "Message from XOR puzzle validation"
  value       = try(ctfchallenge_puzzle_box.xor_puzzle.message, "Not attempted")
}

output "xor_puzzle_secret" {
  description = "🏴 BONUS FLAG from XOR puzzle!"
  value       = try(ctfchallenge_puzzle_box.xor_puzzle.secret_output, "🔒 Not captured yet")
  sensitive   = true
}

output "xor_puzzle_info" {
  description = "XOR puzzle information"
  value = {
    input_numbers = var.xor_solution
    solved        = try(ctfchallenge_puzzle_box.xor_puzzle.solved, false)
    message       = try(ctfchallenge_puzzle_box.xor_puzzle.message, "Not attempted")
  }
}