resource "null_resource" "xor_demonstration" {
  triggers = {
    numbers      = jsonencode([15, 23, 42, 37, 11])
    solution_key = "XOR of all five numbers equals zero"
  }
}

resource "ctfchallenge_puzzle_box" "xor_puzzle" {
  inputs = var.xor_solution

  depends_on = [null_resource.xor_demonstration]
}