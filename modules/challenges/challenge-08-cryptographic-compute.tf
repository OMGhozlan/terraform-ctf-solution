# ============================================================================
# Challenge 8: Cryptographic Compute
# ============================================================================
# Objective: Use Terraform's cryptographic functions
# Points: 500
# Difficulty: Advanced
#
# Task: Compute md5(sha256("terraform_ctf_11_2025"))
# ============================================================================

resource "null_resource" "crypto_operations" {
  count = local.challenges_enabled.cryptographic_compute ? 1 : 0

  triggers = {
    final_hash = local.crypto_final_hash
  }
}

# Submit proof of work - flag will be revealed upon success!
resource "ctfchallenge_flag_validator" "cryptographic_compute" {
  count = local.challenges_enabled.cryptographic_compute ? 1 : 0

  challenge_id = local.challenge_metadata.cryptographic_compute.id

  proof_of_work = {
    crypto_hash = local.crypto_final_hash
  }

  depends_on = [null_resource.crypto_operations]
}