provider "aws" {
  profile = var.profile
  region = var.region

  assume_role {
    role_arn = var.assumeRole ? "arn:aws:iam::${var.accountID}:role/${var.assumableRole}" : null
  }
}

resource "aws_ebs_volume" "vss" {
  availability_zone     = var.availability_zone

  size                  = var.size

  type                  = var.type
  iops                  = var.type == "io1" || var.type == "io2" || var.type == "gp3" ? var.iops : ""
  throughput            = var.type == "gp3" ? var.throughput : null
  multi_attach_enabled  = var.type == "io1" || var.type == "io2" ? var.multi_attach : false

  encrypted             = var.encrypted
  kms_key_id            = var.kms_key_id

  final_snapshot        = var.final_snapshot

  tags = {
    Name = var.name
  }
}

resource "aws_volume_attachment" "vss" {
  count = var.attach && length(var.instances) > 0 ? length(var.instances) : 0

  instance_id = var.instances[count.index]

  device_name = var.device_name
  volume_id   = aws_ebs_volume.vss.id

  force_detach = var.force_detach
  stop_instance_before_detaching = var.stop_instance_before_detaching
}