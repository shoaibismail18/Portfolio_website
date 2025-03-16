import boto3

ecs_client = boto3.client('ecs', region_name="us-east-1")  # Update with your region

CLUSTER_NAME = "portfolio-web-cluster"
SERVICE_NAME = "portfolio-service"

def lambda_handler(event, context):
    try:
        response = ecs_client.update_service(
            cluster=CLUSTER_NAME,
            service=SERVICE_NAME,
            forceNewDeployment=True
        )
        return {
            'statusCode': 200,
            'body': 'ECS service updated successfully!'
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': f'Error updating ECS service: {str(e)}'
        }
