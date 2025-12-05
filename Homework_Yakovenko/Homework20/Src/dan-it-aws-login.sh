#!/bin/bash

AWS_ACCOUNT_ID="626126209976" # DatIT AWS account ID
PROFILE_NAME_WITHOUT_MFA="danit-without-mfa"
MFA_DEVICE_NAME=$(aws --profile $PROFILE_NAME_WITHOUT_MFA iam list-mfa-devices --user-name "$(aws --profile $PROFILE_NAME_WITHOUT_MFA sts get-caller-identity | jq -r '.Arn | split("/")[1]')" | jq -r '.MFADevices[0].SerialNumber')
PROFILE_NAME_WITH_MFA="default"

read -p "Enter MFA code: " MFA_CODE

CREDS=$(aws --profile $PROFILE_NAME_WITHOUT_MFA sts get-session-token \
    --serial-number $MFA_DEVICE_NAME \
    --token-code $MFA_CODE \
    --query 'Credentials.[AccessKeyId, SecretAccessKey, SessionToken]' \
    --output text)

if [ $? -ne 0 ]; then
    echo "Error: Failed to get session token. Please check your MFA setup and try again."
    exit 1
fi

ACCESS_KEY_ID=$(echo $CREDS | awk '{print $1}')
SECRET_ACCESS_KEY=$(echo $CREDS | awk '{print $2}')
SESSION_TOKEN=$(echo $CREDS | awk '{print $3}')

aws configure set aws_access_key_id "$ACCESS_KEY_ID" --profile $PROFILE_NAME_WITH_MFA
aws configure set aws_secret_access_key "$SECRET_ACCESS_KEY" --profile $PROFILE_NAME_WITH_MFA
aws configure set aws_session_token "$SESSION_TOKEN" --profile $PROFILE_NAME_WITH_MFA

echo "Temporary credentials saved under profile '$PROFILE_NAME_WITH_MFA'."

echo "Use this profile by running commands with --profile $PROFILE_NAME_WITH_MFA, or set it as the default by updating AWS_DEFAULT_PROFILE."