module "network_example" {
  count = local.challenges_enabled.module_master ? 1 : 0

  source = "../network-example"

  environment  = "ctf-challenge"
  vpc_cidr     = "10.0.0.0/16"
  subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  tags = merge(local.common_tags, {
    Challenge = "Module Master"
  })
}

resource "null_resource" "module_consumer" {
  count = local.challenges_enabled.module_master ? 1 : 0

  triggers = {
    vpc_id           = module.network_example[0].vpc_id
    module_reference = "module.network_example[0].vpc_id = ${module.network_example[0].vpc_id}"
  }
}

resource "ctfchallenge_flag_validator" "module_master" {
  count = local.challenges_enabled.module_master ? 1 : 0

  challenge_id = local.challenge_metadata.module_master.id
  flag         = local.challenge_metadata.module_master.flag

  proof_of_work = {
    module_output = "module.network_example[0].vpc_id = ${module.network_example[0].vpc_id}"
  }

  depends_on = [module.network_example]
}