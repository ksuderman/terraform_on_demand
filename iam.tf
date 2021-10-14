resource "aws_iam_role" "trust" {
    name = "allow-assume-role"
    assume_role_policy = "${file("./files/iam_trust_policy.json")}"
}

resource "aws_iam_policy" "policy" {
  name        = "iam_policy"
  path        = "/"
  policy = "${file("./files/iam_policy.json")}"
}

resource "aws_iam_policy_attachment" "policy-attach" {
  name       = "policy-attachment"
  roles      = ["${aws_iam_role.trust.name}"] #, "${aws_iam_role.cn.name}"]
  policy_arn = "${aws_iam_policy.policy.arn}"
}

resource "aws_iam_instance_profile" "profile" {
  name  = "profile"
  role = aws_iam_role.trust.name
}
