#!/bin/bash
# IAM Access Control Lab
# These are the CLI commands used to build this project

# Step 1 - Create IAM group
aws iam create-group --group-name nextwork-dev-group

# Step 2 - Create IAM user
aws iam create-user --user-name nextwork-dev-yeshi

# Step 3 - Add user to group
aws iam add-user-to-group \
    --user-name nextwork-dev-yeshi \
    --group-name nextwork-dev-group

# Step 4 - Create the policy
aws iam create-policy \
    --policy-name nextwork-dev-policy \
    --policy-document file://iam-policy.json

# Step 5 - Attach policy to group
aws iam attach-group-policy \
    --group-name nextwork-dev-group \
    --policy-arn arn:aws:iam::YOUR_ACCOUNT_ID:policy/nextwork-dev-policy

# Cleanup - Run these when done
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
