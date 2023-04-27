# Account setup
variable "profile" {
  description           = "The profile from ~/.aws/credentials file used for authentication. By default it is the default profile."
  type                  = string
  default               = "default"
}

variable "accountID" {
  description           = "ID of your AWS account. It is a required variable normally used in JSON files or while assuming a role."
  type                  = string

  validation {
    condition           = length(var.accountID) == 12
    error_message       = "Please, provide a valid account ID."
  }
}

variable "region" {
  description           = "The region for the resources. By default it is eu-west-1."
  type                  = string
  default               = "eu-west-1"
}

variable "assumeRole" {
  description           = "Enable / Disable role assume. This is disabled by default and normally used for sub organization configuration."
  type                  = bool
  default               = false
}

variable "assumableRole" {
  description           = "The role the user will assume if assumeRole is enabled. By default, it is OrganizationAccountAccessRole."
  type                  = string
  default               = "OrganizationAccountAccessRole"
}

variable "name" {
  description = "Name of the volume in AWS console. Required value"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone where the volume is located. Eg.: eu-west-1a for eu-west-1 region. Value is required"
  type        = string
}
variable "size" {
  description = "The size of the drive in GBs. Defaults to 5GB."
  type        = number
  default     = 5
}
variable "type" {
  description = "The type of the EBS volume. Allowed values are standard, gp2, gp3, io1, io2, sc1 or st1. Defaults to gp3."
  type        = string
  default     = "gp3"

  validation {
    condition           = contains(["standard", "gp2", "gp3", "io1", "io2", "sc1", "st1"], var.type)
    error_message       = "Expected values: standard, gp2, gp3, io1, io2, sc1, st1."
  }
}
variable "iops" {
  description = "The amount of IOPS to provision for the disk. This value is available only for type io1, io2 and gp3"
  type        = number
  default     = null
}
variable "multi_attach" {
  description = "Enable/Disable the option to mount the volume to multiple instances. By default this value is false. This value is available only for type io1 and io2"
  type        = bool
  default     = false
}
variable "encrypted" {
  description = "Enable/Disable disk encryption. By default, disk is encrypted"
  type        = bool
  default     = true
}
variable "kms_key_id" {
  description = "In case you want to encrypt the disk with your own key, please provide the kms_key_id."
  type        = string
  default     = ""
}
variable "final_snapshot" {
  description = "Enable or disable final snapshot beefore the volume is deleted."
  type        = bool
  default     = false
}
variable "attach" {
  description = "Enable or disable the attachment to an instance. If enabled, instance or list of instances must be provided. Defaults to false."
  type        = bool
  default     = false
}
variable "instances" {
  description = "Instance or list of instances to attach the volume to formated as list. However multiple instances are only supported if multi_attach is enabled and the type is io1 or io2."
  type        = list(string)
  default     = []
}
variable "device_name" {
  description = "Name of the device as shown in Linux or Windows. By default xvdz"
  type        = string
  default     = "xvdz"
}
variable "force_detach" {
  description = "If true, volume will be detached even if it is in use. This can result in data loss. Defaults to false"
  type        = bool
  default     = false
}
variable "stop_instance_before_detaching" {
  description = "If set to true, volume will be detached only if the instance is stopped. Defaults to false"
  type        = bool
  default     = false
}