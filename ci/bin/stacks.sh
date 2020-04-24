#!/usr/bin/env bash

#Params
CLUSTER=1
MEGACLUSTER=1

if [ $CLUSTER == 1 ]; then

echo "Create AWS EKS Cluster"
echo $(aws s3 cp s3://build-secure/params/amazon-eks.json - ) > amazon-eks.json
aws cloudformation create-stack --disable-rollback --stack-name eks-tmp-${DATE} --disable-rollback --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
    --parameters file:///${CODEBUILD_SRC_DIR}/amazon-eks.json \
    --template-url https://s3.amazonaws.com/solodev-quickstarts/eks/1.14/templates/solodev-eks.yaml \
    # --notification-arns $NOTIFICATION_ARN

fi

if [ $MEGACLUSTER == 1 ]; then

echo "Create AWS EKS Mega Cluster"
echo $(aws s3 cp s3://build-secure/params/amazon-eks-mega.json - ) > amazon-eks.json
aws cloudformation create-stack --disable-rollback --stack-name eksmega-${DATE} --disable-rollback --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
    --parameters file:///${CODEBUILD_SRC_DIR}/amazon-eks.json \
    --template-url https://s3.amazonaws.com/solodev-quickstarts/eks/1.14/templates/solodev-eks.yaml \
    # --notification-arns $NOTIFICATION_ARN

fi