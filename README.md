# Github Actions CI/CD Documentation

##Overview

![image](https://github.com/user-attachments/assets/f7e0d036-8eb6-403a-b275-405a8f674cda)

![image](https://github.com/user-attachments/assets/256d597e-bc3c-4b3b-8faf-5007fe29b38e)

In this project we are automating the build creation of a node.js based project. The plan was to create two pipelines that will handle the both pull request, and build and push or docker image to a ECR repository. 

We also identified that their are steps involved in both pipelines such as the following: 
- audit: checking the dependencies for vulnerabilities in between steps of the CI/CD is good practice as new vulnerabilities can appear without notice.
- test: to make sure that in instances that developers create a last minute change, we are able to check if all of the expected functions still works.
therefore, we considered making reusable workflows for them.

Other steps included in pipeline plan
- Sonar Scan: we will use an open source tool named [SonarQube](https://www.sonarsource.com/products/sonarqube/)
- Build and Push: we will use [Docker](https://www.docker.com/) to build the node.js application. This will make sure that the environment that the application will run on is consistent. We will also be deploying this docker image in a private repository hosted in AWS([ECR](https://aws.amazon.com/ecr/))

With all those considered, we can conclude that we need the following github workflow files:
- [Audit]() (reusable workflow triggered by others)
- [Test]() (reusable workflow triggered by others)
- [On Pull Request]()
- [Build and Push]()

  






