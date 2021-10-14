# resource "aws_iam_role" "this" {
#   name               = "gha-role"
#   assume_role_policy = jsonencode({
#         "Version": "2012-10-17",
#         "Statement": [
#         {
#             "Action": "sts:AssumeRole",
#             "Principal": {
#             "Service": "ec2.amazonaws.com"
#             },
#             "Effect": "Allow",
#             "Sid": ""       
#         }
#         ]
#     })
# }

resource "aws_iam_role" "trust" {
    name = "allow-assume-role"
    assume_role_policy = "${file("./files/iam_trust_policy.json")}"
}

# resource "aws_iam_role" "cn" {
#     name = "allow-assume-role-cn"
#     assume_role_policy = "${file("./files/iam_trust_policy-cn.json")}"
# }

resource "aws_iam_policy" "policy" {
  name        = "iam_policy"
  path        = "/"
  policy = "${file("./files/iam_policy.json")}"
}

# resource "aws_iam_policy" "trust" {
#   name        = "iam_trust_policy"
#   path        = "/"
#   policy = "${file("./files/iam_trust_policy.json")}"
# }
# resource "aws_iam_role" "trust" {
#     assume_role_policy = "${file("./files/iam_trust_policy.json")}"
# }

# resource "aws_iam_policy" "cn" {
#   name        = "iam_trust_policy_cn"
#   path        = "/"
#   policy = "${file("./files/iam_trust_policy-cn.json")}"
# }

resource "aws_iam_policy_attachment" "policy-attach" {
  name       = "policy-attachment"
  roles      = ["${aws_iam_role.trust.name}"] #, "${aws_iam_role.cn.name}"]
  policy_arn = "${aws_iam_policy.policy.arn}"
}

# resource "aws_iam_policy_attachment" "trust-attach" {
#   name       = "trust-attachment"
#   roles      = ["${aws_iam_role.this.name}"]
#   policy_arn = "${aws_iam_policy.trust.arn}"
# }

# resource "aws_iam_policy_attachment" "cn-attach" {
#   name       = "cn-attachment"
#   roles      = ["${aws_iam_role.this.name}"]
#   policy_arn = "${aws_iam_policy.cn.arn}"
# }

resource "aws_iam_instance_profile" "profile" {
  name  = "profile"
  role = aws_iam_role.trust.name
}
