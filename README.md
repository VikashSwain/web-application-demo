# web-application-Deployment
Deploy the NGINX application in Kubernetes using a Docker image, expose it via a Service, deploy Prometheus to monitor it by scraping metrics from the Prometheus exporter, and optionally visualize the metrics in Grafana.

Overview
This document outlines the steps to deploy a static web application in a cloud-based Kubernetes solution, leveraging AWS EKS for orchestration, Terraform for infrastructure provisioning, and Prometheus & Grafana for monitoring.
***********************************************************************************************************************************************************
* Prerequisites
AWS CLI configured with appropriate credentials.
Kubernetes CLI (kubectl) installed and configured.
Docker installed and running.
Terraform installed on your machine.
A GitHub repository for your application and infrastructure code.

***********************************************************************************************************************************************************
STEP 1  : Infrastructure Provisioning with Terraform
          Write a Terraform Code
          main.tf: Defines the EKS cluster and node groups.
          iam.tf: Defines IAM, ROLES for EKS and Nodegroup.
          provide.tf: Define which provider is used [AWS]
          vpc.tf: Defines networking for EKS.
          sg.tf: Defines Security for EKS.

          with the terraform code [VPC, subnet, internetgateway, Route table, EKS cluster, 1 Nodegroup] was created
          
STEP 2 : Initialize and Apply Terraform

         terraform init
         terraform validate
         terraform plan
         terraform apply

STEP 3: Create Dockerfile ,Image and Run container

        Docker build -t swainvikash/nginx12 .
        
        then run the container to test , after successful run image was pushed to docker hub registry
        [docker push swainvikash/nginx12]

STEP 4: Create Kubernetes Deployment Files
        Created deployment yml file for swainvikash/nginx12 image with 2 replicas.
        created service with type Loadbalancer expose on port 80.
        
        kubectl apply -f kubernetes/deployment.yml
        kubectl apply -f kubernetes/service.yml
        
STEP 5: Setting Up Monitoring with Prometheus and Grafana
        Use Helm to install Prometheus and Grafana in the monitoring namespace
        Validate the application by accessing the LoadBalancer URL of the web application service.
        Monitor metrics in Prometheus and visualize them in Grafana.

        below I have attached image of the project.

        ![demo-web-app](https://github.com/user-attachments/assets/72bd8ec6-6f13-4a8d-a557-ac3869711ac3)

        ![Grafana-dashboard](https://github.com/user-attachments/assets/52bd5df9-bd20-48ad-91d6-00dc505f6c23)

        ![cluster](https://github.com/user-attachments/assets/11d5d706-2f0e-4b0b-be86-0be7d20eb3a9)

        ![pods-k8s](https://github.com/user-attachments/assets/e5d89b8a-4215-411f-b857-690c207e0874)

        
