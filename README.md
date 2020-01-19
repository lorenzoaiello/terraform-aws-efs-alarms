# Terraform Module for AWS EFS Cloudwatch Alarms

This Terraform module manages Cloudwatch Alarms for an Elastic File System. It does NOT create or manage EFS, only Metric Alarms.

**Requires**:
- AWS Provider
- Terraform 0.12

## Alarms Created

Alarms Always Created (default values can be overridden):
- Disk burst balance less than 100 GB
- IO Percentage above 90%
- Anomalous client connection count
- Anomalous IO pattern (bytes)

**Estimated Operating Cost**: $ 0.80 / month

- $ 0.10 / month for Metric Alarms (2x)
- $ 0.30 / month for Anomaly Alarm (2x)

## Example

```hcl-terraform
resource "aws_efs_file_system" "default" {
  creation_token = "my-filesystem"
}

module "aws-efs-alarms" {
  source            = "lorenzoaiello/efs-alarms/aws"
  version           = "x.y.z"
  efs_id            = aws_efs_file_system.default.id
}

```

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| actions\_alarm | A list of actions to take when alarms are triggered. Will likely be an SNS topic for event distribution. | `list` | `[]` | no |
| actions\_ok | A list of actions to take when alarms are cleared. Will likely be an SNS topic for event distribution. | `list` | `[]` | no |
| anomaly\_period | The number of seconds that make each evaluation period for anomaly detection. | `string` | `"600"` | no |
| efs\_id | EFS ID | `string` | n/a | yes |
| evaluation\_period | The evaluation period over which to use when triggering alarms. | `string` | `"5"` | no |
| prefix | Alarm Name Prefix | `string` | `""` | no |
| statistic\_period | The number of seconds that make each statistic period. | `string` | `"60"` | no |

## Outputs

| Name | Description |
|------|-------------|
| alarm\_anomalous\_client\_connections | The CloudWatch Metric Alarm resource block for anomalous Client Connection Count |
| alarm\_anomalous\_io\_bytes | The CloudWatch Metric Alarm resource block for anomalous IO Bytes |
| alarm\_burst\_balance\_too\_low | The CloudWatch Metric Alarm resource block for low Disk Burst Balance |
| alarm\_io\_percentage\_too\_high | The CloudWatch Metric Alarm resource block for high IO Percentage |
