resource "aws_iam_role" "dlm_role" {
  name = "quibs-dlm-lifecycle-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "dlm.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

data "aws_iam_policy" "dlm_service_role_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSDataLifecycleManagerServiceRole"
}

resource "aws_iam_role_policy_attachment" "dlm_role_attachment" {
  role       = aws_iam_role.dlm_role.name
  policy_arn = data.aws_iam_policy.dlm_service_role_policy.arn
}
