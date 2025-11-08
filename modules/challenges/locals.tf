locals {
  # Use passed-in variables
  challenges_enabled = var.challenges_enabled
  challenge_metadata = var.challenge_metadata
  common_tags        = var.common_tags

  # Expression Expert computation
  expr_step_1_strings = ["terraform", "expressions", "rock"]
  expr_step_2_joined  = join("", local.expr_step_1_strings)
  expr_step_3_hashed  = sha256(local.expr_step_2_joined)
  expr_step_4_encoded = base64encode(local.expr_step_3_hashed)

  # State Secrets
  magic_number = 42

  # Dynamic Blocks
  port_configs = {
    http      = { port = 80, protocol = "tcp", description = "HTTP traffic" }
    https     = { port = 443, protocol = "tcp", description = "HTTPS traffic" }
    alt_http  = { port = 8080, protocol = "tcp", description = "Alternative HTTP" }
    alt_https = { port = 8443, protocol = "tcp", description = "Alternative HTTPS" }
    custom    = { port = 3000, protocol = "tcp", description = "Custom application" }
  }
  dynamic_block_count = length(local.port_configs)

  # For-Each
  greek_letters = toset(["alpha", "beta", "gamma", "delta"])
  greek_metadata = {
    alpha = { order = 1, symbol = "α", meaning = "Beginning" }
    beta  = { order = 2, symbol = "β", meaning = "Second" }
    gamma = { order = 3, symbol = "γ", meaning = "Third" }
    delta = { order = 4, symbol = "Δ", meaning = "Change" }
  }

  # Data Source Detective
  infrastructure_items = {
    web_server_1     = { type = "compute", environment = "prod", active = true }
    web_server_2     = { type = "compute", environment = "prod", active = true }
    db_server_1      = { type = "database", environment = "prod", active = true }
    cache_server_1   = { type = "cache", environment = "prod", active = true }
    web_server_dev_1 = { type = "compute", environment = "dev", active = true }
    db_server_dev_1  = { type = "database", environment = "dev", active = true }
    cache_server_dev = { type = "cache", environment = "dev", active = true }
    backup_server    = { type = "backup", environment = "prod", active = true }
  }
  active_prod_servers = {
    for name, config in local.infrastructure_items :
    name => config if config.environment == "prod" && config.active == true
  }
  filtered_count = length(local.active_prod_servers)

  # Cryptographic Compute
  crypto_secret        = "terraform_ctf_11_2025"
  crypto_step_2_sha256 = sha256(local.crypto_secret)
  crypto_final_hash    = md5(local.crypto_step_2_sha256)
}