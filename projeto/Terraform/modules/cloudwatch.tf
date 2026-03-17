# Busca a região atual para montar o ARN de recuperação
data "aws_region" "current" {}

# 1. Alarme de Auto-Recuperação (Se o hardware da AWS falhar, ela reinicia sozinha)
resource "aws_cloudwatch_metric_alarm" "auto_recovery_web" {
  alarm_name          = "auto-recovery-web-${var.ambiente}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "StatusCheckFailed_System"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Minimum"
  threshold           = "0"

  dimensions = {
    InstanceId = aws_instance.srv_web.id
  }

  alarm_description = "Reinicia a instância se o hardware da AWS apresentar falha"
  alarm_actions     = ["arn:aws:automate:${data.aws_region.current.id}:ec2:recover"]
}

# 2. Alarme de CPU Alta (Para monitorar performance)
resource "aws_cloudwatch_metric_alarm" "cpu_alta_web" {
  alarm_name          = "cpu-high-web-${var.ambiente}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300" # Janela de 5 minutos
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    InstanceId = aws_instance.srv_web.id
  }

  alarm_description = "Alerta se a CPU passar de 80% por 10 minutos"

  alarm_actions = [data.aws_sns_topic.alerta_disponivel.arn]
}