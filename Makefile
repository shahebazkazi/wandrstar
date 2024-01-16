AWS_REGION = us-west-2 //ap-south-1
AWS_ACCOUNT_ID = 852112317381
IMAGE_NAME = wandr-demo-kazi //nodejs-app
TAG = latest

.PHONY: build
build:
	docker build -t $(IMAGE_NAME):$(TAG) .
       // docker build -t wandr-demo-kazi .
.PHONY: run
run: build
	docker run -it -p 8080:8080 $(IMAGE_NAME):$(TAG)

.PHONY: tag
tag: build
	docker tag $(IMAGE_NAME):$(TAG) $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(IMAGE_NAME):$(TAG)
        //docker tag wandr-demo-kazi:latest 852112317381.dkr.ecr.us-west-2.amazonaws.com/wandr-demo-kazi:latest
.PHONY: login
login:
	aws ecr get-login-password --region $(AWS_REGION) | docker login --username AWS --password-stdin $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com
       // aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 852112317381.dkr.ecr.us-west-2.amazonaws.com
.PHONY: push
push: login tag
	docker push $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(IMAGE_NAME):$(TAG)
       // docker push 852112317381.dkr.ecr.us-west-2.amazonaws.com/wandr-demo-kazi:latest
