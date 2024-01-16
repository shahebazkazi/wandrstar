AWS_REGION = ap-south-1
AWS_ACCOUNT_ID = 85211231738
IMAGE_NAME = nodejs-app
TAG = latest

.PHONY: build
build:
	docker build -t $(IMAGE_NAME):$(TAG) .

.PHONY: run
run: build
	docker run -it -p 8080:8080 $(IMAGE_NAME):$(TAG)

.PHONY: tag
tag: build
	docker tag $(IMAGE_NAME):$(TAG) $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(IMAGE_NAME):$(TAG)

.PHONY: login
login:
	aws ecr get-login-password --region $(AWS_REGION) | docker login --username AWS --password-stdin $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com

.PHONY: push
push: login tag
	docker push $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(IMAGE_NAME):$(TAG)
