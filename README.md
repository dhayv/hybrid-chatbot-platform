# DevSecOps: OpenAI Chatbot UI Deployment in EKS and AKS Docker, Kubernetes, and Terraform

![text](https://imgur.com/MdxoqmL.png)

## **Introduction:**

In today’s digital world, user engagement is key to the success of any application. Implementing DevSecOps practices is essential for ensuring security, reliability, and efficient deployment processes. In this project, we aim to implement DevSecOps for deploying an OpenAI Chatbot UI. We will use Kubernetes (EKS) for container orchestration, Jenkins for Continuous Integration/Continuous Deployment (CI/CD), and Docker for containerization.

**What is ChatBOT?**

ChatBOT is an AI-powered conversational agent trained on extensive human conversation data. It utilizes natural language processing techniques to understand user queries and provide human-like responses. By simulating natural language interactions, ChatBOT enhances user engagement and provides personalized assistance to users.

**Why ChatBOT?**

**1\. Personalized Interactions:** ChatBOT enables personalized interactions by understanding user queries and responding in a conversational manner, fostering engagement and satisfaction.  
  
**2\. 24/7 Availability:** Unlike human agents, ChatBOT is available 24/7, ensuring instant responses to user queries and delivering a seamless user experience round the clock.  
  
**3\. Scalability:** With ChatBOT deployed in our application, we can efficiently handle a large volume of user interactions, ensuring scalability as our user base expands.

**How We’re Deploying ChatBOT?**

**1\. Containerization with Docker:** We’re containerizing the ChatBOT application using Docker, which provides lightweight, portable, and isolated environments for running applications. Docker enables consistent deployment across different environments, simplifying the deployment process and ensuring consistency.

**2\. Orchestration with Kubernetes (EKS):** Kubernetes provides powerful orchestration capabilities for managing containerized applications at scale. We’re leveraging Amazon Elastic Kubernetes Service (EKS) to deploy and manage our Docker containers efficiently. EKS automates container deployment, scaling, and management, ensuring high availability and resilience.


**3\. DevSecOps Practices:** Throughout the deployment pipeline, we’re integrating security practices into every stage to ensure the security of our ChatBOT application. This includes vulnerability scanning, code analysis, and security testing to identify and mitigate potential security threats early in the development lifecycle.

By implementing DevSecOps practices and leveraging modern technologies like Kubernetes and Docker,  we’re ensuring the secure, scalable, and efficient deployment of ChatBOT, enhancing user engagement and satisfaction.

# **STEPS:**
**Step: 1 :- Provisioning AKS cluster**
- We navigated to the AKS cluster folder and then after setting up our credentials to connect to AKS run the command:

```
cd AKS-Cluster
terraform apply -auto-approve
az login
az account set --subscription <YourSubscriptionID>
az aks get-credentials --resource-group <ResourceGroupName> --name <AKSClusterName>
```

**Step: 2 :- Deploying Chatbot UI in AKS Cluster **
- To deploy the cluster in my AKS cluster I used the commands:

```
cd ../Chatbot-UI/k8s
kubectl apply -f chatbot-ui.yaml
kubectl apply -f modified-aks-svc.yaml
```

**Step: 3 :- Provisioning EKS cluster**
- We navigated to the EKS cluster folder and then after setting up our credentials to connect to EKS run the command:

```
cd ../../EKS-Cluster
export AWS_ACCESS_KEY_ID=<your-aws-access-key>
export AWS_SECRET_ACCESS_KEY=<your-aws-secret-access-key>
terraform apply -auto-approve

```

**Step: 4 :- Deploying Chatbot UI in EKS Cluster **
- To deploy the cluster in my EKS cluster I used the commands:

```
kubectl config use-context <eks-cluster-name>
cd ../Chatbot-UI
kubectl apply -f chatbot-ui.yaml
kubectl apply -f modified-aks-svc.yaml
```

**Step: 5 :- Viewing Application via Internet for Both AKS and EKS Deployed Chatbot Application**
- Our application is being exposed via a loadbalancer service. To grab the address for the application, in both clusters we will use the command:

```
kubectl get svc 
```
 and then copy and paste the external address into a web browser. Our page should look something like this:

![alt text](image-2.png)



**Step: 6 :- Configuring Multi-Cloud Caching in AWS Cloudfront:
- We used the modified AWS Cloudfront to create two origins: a main and a backup and were able to prove caching and backup routing for two websites even from different cloud platforms based on the updated AWS CloudFront website. Instead of expensive complex DNS routing setup, we could use AWS Cloudfront Multitenant routing to point to two different websites both representing the same software for disaster recovery and disaster recovery planning.

What did we prove?
We proved that you can serve multicluster applications that can be cache and do not require livestreaming using CloudFront as a medium for disaster recovery and failover, as well as possibly splitiing traffic





**Step: 7 :- Clean Up**

1. This is so simple Firstly Delete the EKS and AKS-Cluster navigating to their respective directories and then running the command:.



```go
terraform destroy -auto-approve -var-file=variables.tfvars
```

---
Project originally sourced from:

## 🛠️ Author & Community  

This project is crafted by **[Harshhaa](https://github.com/NotHarshhaa)** 💡.  
I’d love to hear your feedback! Feel free to share your thoughts.  

📧 **Connect with me:**

- **GitHub**: [@NotHarshhaa](https://github.com/NotHarshhaa)
- **Blog**: [ProDevOpsGuy](https://blog.prodevopsguy.xyz)  
- **Telegram Community**: [Join Here](https://t.me/prodevopsguy)  

---

## ⭐ Support the Project  

If you found this helpful, consider **starring** ⭐ the repository and sharing it with your network! 🚀  

### 📢 Stay Connected  

![Follow Me](https://imgur.com/2j7GSPs.png)
