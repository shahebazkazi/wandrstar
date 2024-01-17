AWS_REGION = us-west-2 
AWS_ACCOUNT_ID = 895471402311
IMAGE_NAME = wanderstar-test 
TAG = latest

.PHONY: build
build:
	docker build -t wanderstar-test . 
       
.PHONY: run
run: build
	docker run -it -p 8080:8080 wanderstar-test:latest

.PHONY: tag
tag: build
	docker tag wanderstar-test:latest 895471402311.dkr.ecr.us-west-2.amazonaws.com/wanderstar-test:latest
        
.PHONY: login
login:
	aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 895471402311.dkr.ecr.us-west-2.amazonaws.com
       
.PHONY: push
push: login tag
	docker push 895471402311.dkr.ecr.us-west-2.amazonaws.com/wanderstar-test:latest
       
