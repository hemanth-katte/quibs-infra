resource "aws_instance" "quib_prod" {
  ami                         = "ami-0e438932a2b7f0567"
  associate_public_ip_address = true
  availability_zone           = "us-east-1a"

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  cpu_options {
    core_count       = 1
    threads_per_core = 1
  }

  credit_specification {
    cpu_credits = "standard"
  }

  disable_api_stop        = false
  disable_api_termination = false
  ebs_optimized           = false

  enclave_options {
    enabled = false
  }

  get_password_data                    = false
  hibernation                          = false
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t2.micro"
  ipv6_address_count                   = 0
  key_name                             = "Quib"

  maintenance_options {
    auto_recovery = "default"
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "disabled"
  }

  monitoring                 = false
  placement_partition_number = 0

  private_dns_name_options {
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }

  root_block_device {
    delete_on_termination = true
    encrypted             = false
    volume_size           = 30
    volume_type           = "gp2"
  }

  security_groups   = ["launch-wizard-4"]
  source_dest_check = true
  subnet_id         = "subnet-05404b2d927691027"

  tags = merge(
    local.default_tags,
    {
      Name = "QuibProduction"
    }
  )

  tags_all = merge(
    local.default_tags,
    {
      Name = "QuibProduction"
    }
  )

  tenancy                = "default"
  vpc_security_group_ids = ["sg-0e37fcbbb1d58cf85"]
}

resource "aws_instance" "quib_test" {
  ami                         = "ami-007855ac798b5175e"
  associate_public_ip_address = true
  availability_zone           = "us-east-1b"

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  cpu_options {
    core_count       = 1
    threads_per_core = 2
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  disable_api_stop        = false
  disable_api_termination = false
  ebs_optimized           = true

  enclave_options {
    enabled = false
  }

  get_password_data                    = false
  hibernation                          = false
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t3.medium"
  ipv6_address_count                   = 0
  key_name                             = "Quib"

  maintenance_options {
    auto_recovery = "default"
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "disabled"
  }

  monitoring                 = false
  placement_partition_number = 0

  private_dns_name_options {
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }

  root_block_device {
    delete_on_termination = true
    encrypted             = false
    volume_size           = 30
    volume_type           = "gp2"
  }

  security_groups   = ["launch-wizard-4"]
  source_dest_check = true
  subnet_id         = "subnet-05a687e666379fe29"

  tags = merge(
    local.default_tags,
    {
      Name = "QuibTest"
    }
  )

  tags_all = merge(
    local.default_tags,
    {
      Name = "QuibTest"
    }
  )

  tenancy                = "default"
  vpc_security_group_ids = ["sg-0e37fcbbb1d58cf85"]
}
