output "xor_puzzle_solved" {
  value = try(ctfchallenge_puzzle_box.xor_puzzle.solved, false)
}

output "xor_puzzle_message" {
  value = try(ctfchallenge_puzzle_box.xor_puzzle.message, "Not attempted")
}

output "xor_puzzle_secret" {
  value     = try(ctfchallenge_puzzle_box.xor_puzzle.secret_output, null)
  sensitive = true
}

output "xor_puzzle_info" {
  value = {
    input_numbers = var.xor_solution
    solved        = try(ctfchallenge_puzzle_box.xor_puzzle.solved, false)
    message       = try(ctfchallenge_puzzle_box.xor_puzzle.message, "Not attempted")
  }
}