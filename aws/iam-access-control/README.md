```
██╗ █████╗ ███╗   ███╗
██║██╔══██╗████╗ ████║
██║███████║██╔████╔██║
██║██╔══██║██║╚██╔╝██║
██║██║  ██║██║ ╚═╝ ██║
╚═╝╚═╝  ╚═╝╚═╝     ╚═╝
```

[![AWS](https://img.shields.io/badge/AWS-IAM-orange?style=flat&logo=amazonaws)](https://github.com/Yeshi30/cloud-security-portfolio)
[![CloudTrail](https://img.shields.io/badge/CloudTrail-Logging-blue?style=flat&logo=amazon)](https://github.com/Yeshi30/cloud-security-portfolio)
[![Level](https://img.shields.io/badge/Level-Beginner-green?style=flat)](https://github.com/Yeshi30/cloud-security-portfolio)

> Least-privilege IAM structure with user groups, role assignments, MFA enforcement, and full API activity logging via CloudTrail.

## What It Does

- Create IAM user groups with least-privilege policies
- Assign users to groups based on their role
- Enforce MFA for all users
- Enable CloudTrail to log all API activity
- Test and verify permissions for each group

## Services Used

| Service | Purpose |
|---------|---------|
| AWS IAM | Users, groups, roles, policies |
| AWS CloudTrail | API activity logging |
| AWS Config | Compliance monitoring |

## Steps
```bash
# Create IAM groups
aws iam create-group --group-name Admins
aws iam create-group --group-name Developers
aws iam create-group --group-name ReadOnly

# Attach policies to groups
aws iam attach-group-policy --group-name Admins \
  --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

aws iam attach-group-policy --group-name Developers \
  --policy-arn arn:aws:iam::aws:policy/PowerUserAccess

aws iam attach-group-policy --group-name ReadOnly \
  --policy-arn arn:aws:iam::aws:policy/ReadOnlyAccess

# Enable CloudTrail
aws cloudtrail create-trail --name my-audit-trail \
  --s3-bucket-name my-cloudtrail-logs

aws cloudtrail start-logging --name my-audit-trail
```

## What I Learned

*Fill this in after completing the project*

## Challenges & Fixes

*Document any errors you hit and how you solved them*

## Cleanup
```bash
aws iam delete-group --group-name Admins
aws iam delete-group --group-name Developers
aws iam delete-group --group-name ReadOnly
aws cloudtrail delete-trail --name my-audit-trail
```

## Learn More

| Module | Topic |
|--------|-------|
| [AWS IAM Docs](https://docs.aws.amazon.com/iam) | Official IAM documentation |
| [CloudTrail Docs](https://docs.aws.amazon.com/cloudtrail) | Official CloudTrail documentation |
| [mzazon iam-access-control](https://github.com/mzazon/cloud-projects/tree/main/aws/iam-access-control) | Reference project |
