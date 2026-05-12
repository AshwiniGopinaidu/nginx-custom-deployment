# Custom Nginx Deployment using Docker Compose on AWS EC2

## Project Overview

This project demonstrates how to deploy a **custom Nginx web server** using **Docker** and **Docker Compose** on an **AWS EC2 instance**.  

The Nginx container serves a custom HTML page and runs on port **80**.

---

## Tech Stack

- AWS EC2 (Amazon Linux / Ubuntu)
- Docker
- Docker Compose
- Nginx
- GitHub
- Docker Hub

---

## Project Structure

```bash
nginx-custom-deployment/
│── Dockerfile
│── docker-compose.yml
│── README.md



**Step 1: Launch AWS EC2 Instance**
**Launch an EC2 instance using: Amazon Linux 2023**
  Allow inbound traffic:
    SSH (22)
    HTTP (80)

**Step 2: Install Docker**
  Amazon Linux
    sudo dnf update -y
    sudo dnf install docker -y
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo usermod -aG docker ec2-user
Ubuntu
  sudo apt update -y
  sudo apt install docker.io -y
  sudo systemctl start docker
  sudo systemctl enable docker
  sudo usermod -aG docker ubuntu

**Step 3: Install Docker Compose**
  sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose

  sudo chmod +x /usr/local/bin/docker-compose
  docker-compose --version

**Step 4: Dockerfile**
  FROM nginx:latest

  RUN echo "<h1>Hello from Custom Nginx Container</h1>" > /usr/share/nginx/html/index.html

**Step 5: docker-compose.yml**
  version: '3'

  services:
    nginx-app:
      build: .
      container_name: custom-nginx
      ports:
      - "80:80"

**Step 6: Run Application**
  docker-compose up -d

  Check running containers:

  docker ps
  Access Application

  Open browser:

  http://<EC2-PUBLIC-IP>

  Output:

  Hello from Custom Nginx Container

**Step 7: Push Image to Docker Hub**
  docker login
  docker build -t yourdockerhubusername/custom-nginx:v1 .
  docker push yourdockerhubusername/custom-nginx:v1

**Step 8: Push Code to GitHub**
  git init
  git add .
  git commit -m "Initial commit"
  git branch -M main
  git remote add origin https://github.com/AshwiniGopinaidu/nginx-custom-deployment.git
  git push -u origin main

Features
  Custom Nginx Landing Page
  Dockerized Deployment
  Docker Compose Support
  AWS Cloud Hosting
  GitHub Version Control
  Docker Hub Image Registry
