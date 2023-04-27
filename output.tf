output "id" {
  value = try(aws_ebs_volume.vss.id, "")
}
output "arn" {
  value = try(aws_ebs_volume.vss.arn, "")
}
output "instance_ids" {
  value = try(aws_volume_attachment.vss.*.instance_id, "")
}