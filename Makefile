AWS_REGION = us-west-2 
AWS_ACCOUNT_ID = 852112317381
IMAGE_NAME = wandr-demo-kazi 
TAG = latest

.PHONY: build
build:
	docker build -t wandr-demo-kazi:latest . 
       
.PHONY: run
run: build
	docker run -it -p 8080:8080 wandr-demo-kazi:latest

.PHONY: tag
tag: build
	docker tag wandr-demo-kazi:latest 852112317381.dkr.ecr.us-west-2.amazonaws.com/wandr-demo-kazi:latest
        
.PHONY: login
login:
	aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 852112317381.dkr.ecr.us-west-2.amazonaws.com
       
.PHONY: push
push: login tag
	docker push 852112317381.dkr.ecr.us-west-2.amazonaws.com/wandr-demo-kazi:latest
       
