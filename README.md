# Github Actions CI/CD Documentation

## Overview

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

## Docker image

As mentioned previously we will be using docker in this project, to build the project we created a [docker file]() that describes the image that will be created. The following are the rationale of each notable component inside the [docker file]().

![image](https://github.com/user-attachments/assets/cf761607-f759-416a-9e8f-7fd62df026a0)
- for the base image we choose to use node based on the [alphine linux](https://alpinelinux.org/) operating system. This operating system is lightweight as it is stripped down of other binaries that is unnecessary for this application's usecase unlike other full-blown operating system. It is also more secured, for example `sudo` is not included in alphine linux thus making it impossible for bad actors to execute commands that requires the sudo priviledges.

![image](https://github.com/user-attachments/assets/bc698b32-4c41-4f61-822c-dc383d5423c4)
- creation of a new user is also added to the docker file so that we can later use it as the default user inside the docker image, this will prevent bad actors to perform actions that only the root user can. together with the previous benefits of using [alphine linux](https://alpinelinux.org/) we are able to achieve a more robust security scheme.

![image](https://github.com/user-attachments/assets/0c117b83-86f1-4f37-be3f-cce9de175fe6)
- Permission and access management is also another important part of the docker image wherein we make sure that during build time the files that we copy into docker is only accessible with the docker user and permissions for both group and everyone else should be disabled (this are the 2nd and 3rd digit in the chmod command). Permissions should also make sense on what the role of the file or directory is. For example, a file that does not neet to be executed should not need the execute permission (a outlier would be directories as it is needed to open a directory). Write permissions are also not included in this dockerfile as we dont want our code be rewritten unwillingly. However during testing it was found that write permission is needed in the `dist` directory and not having it their causes `node watch` (a script that listens to code changes) to fail. I recommend this part of the `node start` script to be revisted so that we can revoke this permission moving forward.
