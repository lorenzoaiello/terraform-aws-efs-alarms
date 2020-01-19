output "alarm_burst_balance_too_low" {
  value       = aws_cloudwatch_metric_alarm.burst_balance_too_low
  description = "The CloudWatch Metric Alarm resource block for low Disk Burst Balance"
}

output "alarm_io_percentage_too_high" {
  value       = aws_cloudwatch_metric_alarm.io_percentage_too_high
  description = "The CloudWatch Metric Alarm resource block for high IO Percentage"
}

output "alarm_anomalous_client_connections" {
  value       = aws_cloudwatch_metric_alarm.anomalous_client_connections
  description = "The CloudWatch Metric Alarm resource block for anomalous Client Connection Count"
}

output "alarm_anomalous_io_bytes" {
  value       = aws_cloudwatch_metric_alarm.anomalous_io_bytes
  description = "The CloudWatch Metric Alarm resource block for anomalous IO Bytes"
}
