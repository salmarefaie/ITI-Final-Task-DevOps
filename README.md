# ITI-Final-Task-DevOps

## Description
- Create a simple infrastructure on aws to make secure cluster eks using terraform.
- Deploy and Configure Jenkins on EKS.
- Deploy python app application on EKS cluster using CI/CD jenkins pipeline.


## Tools
- AWS
- Terraform
- Ansible
- Docker 
- Kubernetes
- Scripting 


## Infrastructure
- Required infrastructure to make EKS Cluster is vpc with 4 subnets; 2 public subnets and 2 private subnets, internet gateway, nat and bastion host in public subnets and worker node in private subnets. we will connect with EKS cluster using Ec2 bastion host.

  ![Untitled Diagram drawio](https://user-images.githubusercontent.com/76884936/221486336-3dd39189-b5a3-41c1-93ef-261448e484b0.png)

- To Run Infrastructure 

  ```bash      
   cd Terraform
   terraform init
   terraform plan
   terraform apply
  ```
  
## Build Jenkins Image
- Custiomize jenkins image with kubectl and docker client are built from Docker file and pushed to docker hub. 
- we will need kubectl and docker client in CI/CD Jenkins Pipeline.

  ```bash      
    docker build -t jenkins-image-on-pod .
    docker tag jenkins-image-on-pod salmarefaie29/jenkins-image-on-pod
    docker images
    docker push salmarefaie29/jenkins-image-on-pod
  ```
  
  ![Screenshot from 2023-02-27 01-13-22](https://user-images.githubusercontent.com/76884936/221487573-7367fe83-785d-4527-8a9e-b028bd6ff6d1.png)

## Install AWS CLI and kubectl 
- we need to install aws cli and kubectl on ec2 bastion host to connect with EKS cluster using bastion host machine.
- we will connect with bastion host machine using ssh and transfare key to bastion host machine to connect with node worker through bastion host.

 ```bash      
    chmod 400 project.pem
    scp -i project.pem project.pem ubuntu@3.86.85.134:/home/ubuntu
    ssh -i "project.pem" ubuntu@3.86.85.134
  ```
  
- install kubectl and aws cli using scripting

 ```bash      
    scp -i project.pem install-packages.sh ubuntu@3.86.85.134:/home/ubuntu
    sh install-packages.sh
 ```
 
 ## Enable Docker 
 - we can enable docker manually on node worker and we connect to node worker through bastion host.
 
 ```bash      
    ssh -i "project.pem" ec2-user@10.0.3.18
    sudo systemctl start docker
    sudo systemctl status docker
 ```
