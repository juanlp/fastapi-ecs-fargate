# fastapi-ecs-fargate
CI / CD exercise for Python FastAPI on AWS with ECS Fargate + ALB

## Usage
Repository contains:
- application in Python (FastAPI),
- docker image description (Dockerfile)
- infrastructure as code for AWS

Get code of repo:
```shell
git clone git@github.com:jsporna/fastapi-ecs-fargate.git
cd fastapi-ecs-fargate
```

### Python
Application is simple FastAPI Hello World code to show usage of docker in AWS.
There is also dummy test for CI test job.
Application can be run on localhost with virtual environment approach.
```shell
python3 -m venv venv
source venv/bin/activate
pip install -r dev-reqirements.txt
```
next  
```shell
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```
or
```shell
make run
```

### Docker
Application also can be run on localhost with docker
```shell
docker build -t fastapi-ecs-fargate .
docker run -p 8000:8000 fastapi-ecs-fargate
```
or
```shell
make docker-build
make docker-run
```

### AWS
To build own AWS infrastructure you need:
- [terraform](https://www.terraform.io/), 
- [AWS account](https://aws.amazon.com/resources/create-account/) (free tier is good enough)
- [AWS CLI](https://aws.amazon.com/cli/)

First prepare configuration for aws-cli -> [LINK](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
When it is ready let's create some infrastructure in Cloud
```shell
cd iac
terraform init
terraform plan
```
In terminal will be printed a lot of new resources (33). Next let's apply it to AWS:
```shell
terraform apply
```
