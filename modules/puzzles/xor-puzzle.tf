# ============================================================================
# XOR Puzzle - Bonus Challenge
# ============================================================================
# Find 5 numbers whose XOR equals 0
# 
# XOR Properties:
#   a XOR a = 0 (self-cancellation)
#   a XOR 0 = a (identity)
#
# Example solutions:
#   1. All zeros: 0, 0, 0, 0, 0
#   2. Pairs: 5, 5, 7, 7, 0
#   3. Calculated: 15, 23, 42, 37, 11 (where 15^23^42^37 = 11)
# ============================================================================

resource "null_resource" "xor_demonstration" {
  triggers = {
    hint         = "Find 5 numbers whose XOR equals zero"
    property_1   = "a XOR a = 0"
    property_2   = "a XOR 0 = a"
    solution_key = "XOR of all five numbers must equal zero"
  }
}

# Submit your XOR puzzle solution
resource "ctfchallenge_puzzle_box" "xor_puzzle" {
  inputs = var.xor_solution

  depends_on = [null_resource.xor_demonstration]
}