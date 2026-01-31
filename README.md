```
VProfile – Local Setup (Docker)

This project runs a 3-tier Java application (Nginx + Tomcat + MySQL) using Docker Compose.

Prerequisites

Docker ≥ 20.x

Docker Compose v2

step 1)Clone the repository
git clone https://github.com/tabarak23/eks-java.git
cd eks-java
```

Step 2)Build Docker images

![image alt](https://github.com/tabarak23/eks-java/blob/9748eeefb2c0b989a5440728dbbba32d0d0b5ff7/images/Screenshot%20from%202026-01-31%2015-21-00.png)  

docker compose build


Step 3) Start the application

![image alt](https://github.com/tabarak23/eks-java/blob/46da6c93b6e3d310ca87590f58a5f9118ff4e21b/images/Screenshot%20from%202026-01-31%2014-34-06.png)

docker compose up -d

Step 4) Access the Application 

![image alt](https://github.com/tabarak23/eks-java/blob/46da6c93b6e3d310ca87590f58a5f9118ff4e21b/images/Screenshot%20from%202026-01-31%2014-34-26.png)

http:://localhost:8080

Step 5) Stop & Clean Up

![image alt](https://github.com/tabarak23/eks-java/blob/46da6c93b6e3d310ca87590f58a5f9118ff4e21b/images/Screenshot%20from%202026-01-31%2014-34-54.png)

docker compose down


Notes

(i)Application containers run as non-root users

(ii)Images are production-ready and Kubernetes/EKS compatible
