resource "aws_cloudwatch_metric_alarm" "burst_balance_too_low" {
  alarm_name          = "${var.prefix}efs-${var.efs_id}-lowBurstBalance"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.evaluation_period
  metric_name         = "BurstCreditBalance"
  namespace           = "AWS/EFS"
  period              = var.statistic_period
  statistic           = "Average"
  threshold           = "100000000000" # 100 GB in Bytes
  alarm_description   = "Average burst credit balance is low, a performance impact will occur within the hour."
  alarm_actions       = var.actions_alarm
  ok_actions          = var.actions_ok

  dimensions = {
    FileSystemId = var.efs_id
  }
}

resource "aws_cloudwatch_metric_alarm" "io_percentage_too_high" {
  alarm_name          = "${var.prefix}efs-${var.efs_id}-highIOPercentage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_period
  metric_name         = "PercentIOLimit"
  namespace           = "AWS/EFS"
  period              = var.statistic_period
  statistic           = "Maximum"
  threshold           = "90"
  alarm_description   = "I/O limit has been reached, consider using Max I/O performance mode."
  alarm_actions       = var.actions_alarm
  ok_actions          = var.actions_ok

  dimensions = {
    FileSystemId = var.efs_id
  }
}

resource "aws_cloudwatch_metric_alarm" "anomalous_client_connections" {
  alarm_name          = "${var.prefix}efs-${var.efs_id}-anomalousClientConnections"
  comparison_operator = "GreaterThanUpperThreshold"
  evaluation_periods  = var.evaluation_period
  threshold_metric_id = "e1"
  alarm_description   = "Anomalous database connection count detected. Something unusual is happening."
  alarm_actions       = var.actions_alarm
  ok_actions          = var.actions_ok

  metric_query {
    id          = "e1"
    expression  = "ANOMALY_DETECTION_BAND(m1)"
    label       = "ClientConnections (Expected)"
    return_data = "true"
  }

  metric_query {
    id          = "m1"
    return_data = "true"
    metric {
      metric_name = "ClientConnections"
      namespace   = "AWS/EFS"
      period      = var.anomaly_period
      stat        = "Average"
      unit        = "Count"

      dimensions = {
        FileSystemId = var.efs_id
      }
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "anomalous_io_bytes" {
  alarm_name          = "${var.prefix}efs-${var.efs_id}-anomalousIOBytes"
  comparison_operator = "GreaterThanUpperThreshold"
  evaluation_periods  = var.evaluation_period
  threshold_metric_id = "e1"
  alarm_description   = "Anomalous IO pattern detected. Something unusual is happening."
  alarm_actions       = var.actions_alarm
  ok_actions          = var.actions_ok

  metric_query {
    id          = "e1"
    expression  = "ANOMALY_DETECTION_BAND(m1)"
    label       = "TotalIOBytes (Expected)"
    return_data = "true"
  }

  metric_query {
    id          = "m1"
    return_data = "true"
    metric {
      metric_name = "TotalIOBytes"
      namespace   = "AWS/EFS"
      period      = var.anomaly_period
      stat        = "Average"
      unit        = "Count"

      dimensions = {
        FileSystemId = var.efs_id
      }
    }
  }
}