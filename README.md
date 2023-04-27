# mod-terraform-aws-ec2-volume

Terraform module to create AWS EC2 Volumes

## Variables

- **profile** - The profile from ~/.aws/credentials file used for authentication. By default it is the default profile.
- **accountID** - ID of your AWS account. It is a required variable normally used in JSON files or while assuming a role.
- **region** - The region for the resources. By default it is eu-west-1.
- **assumeRole** - Enable / Disable role assume. This is disabled by default and normally used for sub organization configuration.
- **assumableRole** - The role the user will assume if assumeRole is enabled. By default, it is OrganizationAccountAccessRole.
- **name** - Name of the volume in AWS console. Required value
- **availability_zone** - Availability zone where the volume is located. Eg.: eu-west-1a for eu-west-1 region. Value is required
- **size** - The size of the drive in GBs. Defaults to 5GB.
- **type** - The type of the EBS volume. Allowed values are standard, gp2, gp3, io1, io2, sc1 or st1. Defaults to gp3.
- **iops** - The amount of IOPS to provision for the disk. This value is available only for type io1, io2 and gp3
- **multi_attach** - Enable/Disable the option to mount the volume to multiple instances. By default this value is false. This value is available only for type io1 and io2
- **encrypted** - Enable/Disable disk encryption. By default, disk is encrypted
- **kms_key_id** - In case you want to encrypt the disk with your own key, please provide the kms_key_id.
- **final_snapshot** - Enable or disable final snapshot beefore the volume is deleted.
- **attach** - Enable or disable the attachment to an instance. If enabled, instance or list of instances must be provided. Defaults to false.
- **instances** - Instance or list of instances to attach the volume to formated as list. However multiple instances are only supported if multi_attach is enabled and the type is io1 or io2.
- **device_name** - Name of the device as shown in Linux or Windows. By default xvdz
- **force_detach** - If true, volume will be detached even if it is in use. This can result in data loss. Defaults to false
- **stop_instance_before_detaching** - If set to true, volume will be detached only if the instance is stopped. Defaults to false

## Example

### With own key
``` terraform
variable accountID { default = "123456789012"}

module "ec2_volume_instance1 {
  source   = "git::https://github.com/virsas/mod-terraform-aws-ec2-volume.git?ref=v1.0.0"

  profile = "default"
  accountID = var.accountID
  region = "eu-west-1"

  name              = "instance1"
  availability_zone = "eu-west-1a"
  size              = 500

  attach            = true
  instances         = [module.ec2_instance1.id]
  device_name       = "xvdb"
}

```

## Outputs

- id
- arn
- instance_ids
