.PHONY: run build tests lint clean docker-build docker-run ecr-login

clean:
	rm -rf ./.pytest_cache
	rm -f .coverage

tests:
	pytest --cov-report=term-missing --cov=app tests/ --color=yes

docker-build:
	docker build -t fastapi-ecs-fargate .

docker-run:
	docker run --rm -p 8000:8000 --name fastapi-ecs-fargate fastapi-ecs-fargate

ecr-login:
	$(shell aws ecr get-login --region ${AWS_DEFAULT_REGION} --no-include-email)

run:
	uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

lint: clean
	flake8 app --exit-zero
	pylint app --exit-zero
