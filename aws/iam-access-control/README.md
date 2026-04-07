```
██╗ █████╗ ███╗   ███╗
██║██╔══██╗████╗ ████║
██║███████║██╔████╔██║
██║██╔══██║██║╚██╔╝██║
██║██║  ██║██║ ╚═╝ ██║
╚═╝╚═╝  ╚═╝╚═╝     ╚═╝
```

[![AWS](https://img.shields.io/badge/AWS-IAM-orange?style=flat&logo=amazonaws)](https://github.com/Yeshi30/cloud-security-portfolio)
[![EC2](https://img.shields.io/badge/Amazon-EC2-blue?style=flat&logo=amazon)](https://github.com/Yeshi30/cloud-security-portfolio)
[![Level](https://img.shields.io/badge/Level-Beginner-green?style=flat)](https://github.com/Yeshi30/cloud-security-portfolio)

> Built a least-privilege IAM policy to protect a production EC2 instance 
> from an intern user — tested and verified using the IAM Policy Simulator.

## Problem

A new intern needs access to a development EC2 instance but must be completely 
blocked from the production environment. Without proper IAM controls, a single 
mistake could take down a production server and cause serious business disruption.

## Solution

Create a tag-based IAM policy that restricts the intern to only the development 
instance using resource tags. Attach the policy to a user group so permissions 
are managed at the group level. Verify everything works using real login testing 
and the IAM Policy Simulator before granting access.

## Architecture
```
IAM User (intern)
    └── nextwork-dev-group
            └── nextwork-dev-policy
                    ├── ALLOW ec2:* on Env=development instances
                    ├── ALLOW ec2:Describe* on all instances
                    └── DENY ec2:DeleteTags / ec2:CreateTags on all
```

## Services Used

| Service | Purpose |
|---------|---------|
| AWS IAM | Users, groups, policies |
| Amazon EC2 | Production and development instances |
| IAM Policy Simulator | Testing permissions safely |

## Steps
```bash
# Create IAM group
aws iam create-group --group-name nextwork-dev-group

# Create IAM user
aws iam create-user --user-name nextwork-dev-yeshi

# Add user to group
aws iam add-user-to-group \
    --user-name nextwork-dev-yeshi \
    --group-name nextwork-dev-group

# Create and attach policy
aws iam create-policy \
    --policy-name nextwork-dev-policy \
    --policy-document file://iam-policy.json

aws iam attach-group-policy \
    --group-name nextwork-dev-group \
    --policy-arn arn:aws:iam::YOUR_ACCOUNT_ID:policy/nextwork-dev-policy
```

## Test Results

| Action | Instance | Result |
|--------|---------|--------|
| Stop instance | Production | Denied |
| Stop instance | Development | Allowed |
| Delete tags | Any | Denied |
| Describe instances | Any | Allowed |

## What I Learned

- IAM policies use Effect, Action, and Resource to control permissions
- Tags are a powerful way to apply policies to specific resources
- The IAM Policy Simulator lets you test permissions without disrupting live resources
- Least privilege means giving users only exactly what they need — nothing more
- The most challenging part was understanding how JSON policy statements work together

## Cleanup
```bash
aws iam detach-group-policy \
    --group-name nextwork-dev-group \
    --policy-arn arn:aws:iam::YOUR_ACCOUNT_ID:policy/nextwork-dev-policy
aws iam remove-user-from-group \
    --user-name nextwork-dev-yeshi \
    --group-name nextwork-dev-group
aws iam delete-user --user-name nextwork-dev-yeshi
aws iam delete-group --group-name nextwork-dev-group
aws iam delete-policy \
    --policy-arn arn:aws:iam::YOUR_ACCOUNT_ID:policy/nextwork-dev-policy
```

## License

MIT
