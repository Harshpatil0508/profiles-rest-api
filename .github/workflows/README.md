# GitHub Actions Setup for EKS Deployment

## Prerequisites

1. **AWS Credentials**: Add the following secrets to your GitHub repository:
   - `AWS_ACCESS_KEY_ID`: Your AWS access key
   - `AWS_SECRET_ACCESS_KEY`: Your AWS secret key

2. **EKS Cluster**: Ensure your EKS cluster `profiles-rest-api-cluster` exists and is accessible

3. **ECR Repository**: Ensure ECR repository `profiles-rest-api-ecr` exists

## Adding Secrets to GitHub

1. Go to your repository on GitHub
2. Click on Settings → Secrets and variables → Actions
3. Click "New repository secret"
4. Add the following secrets:
   - Name: `AWS_ACCESS_KEY_ID`, Value: Your AWS access key
   - Name: `AWS_SECRET_ACCESS_KEY`, Value: Your AWS secret key

## Workflow Triggers

The deployment workflow triggers on:
- Push to `main` branch
- Pull requests to `main` branch

## Manual Deployment

You can also trigger the workflow manually from the Actions tab in your GitHub repository.

## Monitoring

Check the Actions tab in your repository to monitor deployment progress and logs.
