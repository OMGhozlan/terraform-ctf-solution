resource "null_resource" "crypto_operations" {
  count = local.challenges_enabled.cryptographic_compute ? 1 : 0

  triggers = {
    final_hash = local.crypto_final_hash
  }
}

resource "ctfchallenge_flag_validator" "cryptographic_compute" {
  count = local.challenges_enabled.cryptographic_compute ? 1 : 0

  challenge_id = local.challenge_metadata.cryptographic_compute.id
  flag         = local.challenge_metadata.cryptographic_compute.flag

  proof_of_work = {
    crypto_hash = local.crypto_final_hash
  }

  depends_on = [null_resource.crypto_operations]
}