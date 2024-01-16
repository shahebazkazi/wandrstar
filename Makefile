AWS_REGION = us-west-2 
AWS_ACCOUNT_ID = 852112317381
IMAGE_NAME = wandr-demo-kazi 
TAG = latest

.PHONY: build
build:
	docker build -t wandr-demo-kazi . 
       
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
       
