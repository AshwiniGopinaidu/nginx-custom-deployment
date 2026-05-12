# nginx-custom-deployment

![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-FF9900?style=flat&logo=amazonaws&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat&logo=github&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green.svg)

## 📋 Table of Contents

- [Project Overview](#project-overview)
- [Tech Stack](#tech-stack)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Quick Start](#quick-start)
- [Detailed Setup Instructions](#detailed-setup-instructions)
- [File Descriptions](#file-descriptions)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)
- [Advanced Usage](#advanced-usage)
- [Contributing](#contributing)
- [License](#license)

---

## 📌 Project Overview

This project demonstrates how to deploy a **custom Nginx web server** using **Docker** and **Docker Compose** on an **AWS EC2 instance**. The Nginx container serves a custom HTML page and runs on port **80**, making it an ideal starting point for containerized web deployments on the cloud.

### Key Features

✅ Custom Nginx Landing Page  
✅ Dockerized Deployment  
✅ Docker Compose Support  
✅ AWS Cloud Hosting  
✅ GitHub Version Control  
✅ Docker Hub Image Registry  
✅ Easy to Customize & Scale  

---

## 🛠️ Tech Stack

| Component | Version | Purpose |
|-----------|---------|---------|
| AWS EC2 | Latest | Cloud Infrastructure |
| Docker | Latest | Containerization |
| Docker Compose | Latest | Container Orchestration |
| Nginx | Latest | Web Server |
| GitHub | - | Version Control |
| Docker Hub | - | Image Registry |

---

## 📋 Prerequisites

Before you begin, ensure you have:

- **AWS Account** with EC2 access
- **SSH Client** (PuTTY, OpenSSH, or terminal)
- **Docker Hub Account** (optional, for pushing images)
- **GitHub Account** (for version control)
- **Basic knowledge** of Linux command line

### System Requirements

- **OS**: Amazon Linux 2023 or Ubuntu 20.04+
- **vCPU**: 1 or more
- **RAM**: 512 MB minimum (1 GB recommended)
- **Disk Space**: 10 GB minimum

---

## 📁 Project Structure

```
nginx-custom-deployment/
├── Dockerfile              # Docker image configuration
├── docker-compose.yml      # Docker Compose orchestration
├── html/
│   └── index.html         # Custom landing page (optional)
└── README.md              # Project documentation
```

### Directory Explanation

| File | Description |
|------|-------------|
| `Dockerfile` | Defines the Docker image with Nginx and custom HTML |
| `docker-compose.yml` | Orchestrates container startup and configuration |
| `html/index.html` | Custom HTML content served by Nginx (if used) |
| `README.md` | Project documentation |

---

## 🚀 Quick Start

Get up and running in 5 minutes:

```bash
# 1. SSH into your EC2 instance
ssh -i your-key.pem ec2-user@<EC2-PUBLIC-IP>

# 2. Clone the repository
git clone https://github.com/AshwiniGopinaidu/nginx-custom-deployment.git
cd nginx-custom-deployment

# 3. Start the containers
docker-compose up -d

# 4. Access the application
# Open browser: http://<EC2-PUBLIC-IP>
```

---

## 📖 Detailed Setup Instructions

### Step 1: Launch AWS EC2 Instance

1. Go to [AWS EC2 Dashboard](https://console.aws.amazon.com/ec2/)
2. Click **"Launch Instance"**
3. Select **Amazon Linux 2023** (or Ubuntu 20.04+)
4. Choose **t2.micro** (free tier eligible)
5. Configure security group with inbound rules:
   - **SSH (22)**: 0.0.0.0/0 (or your IP)
   - **HTTP (80)**: 0.0.0.0/0

6. Create/Select key pair and launch

---

### Step 2: Install Docker

#### For Amazon Linux 2023:

```bash
# Update system packages
sudo dnf update -y

# Install Docker
sudo dnf install docker -y

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add ec2-user to docker group (no sudo needed)
sudo usermod -aG docker ec2-user

# Verify installation
docker --version
```

#### For Ubuntu:

```bash
# Update system packages
sudo apt update -y

# Install Docker
sudo apt install docker.io -y

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add ubuntu user to docker group
sudo usermod -aG docker ubuntu

# Verify installation
docker --version
```

---

### Step 3: Install Docker Compose

```bash
# Download latest Docker Compose binary
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 \
  -o /usr/local/bin/docker-compose

# Make it executable
sudo chmod +x /usr/local/bin/docker-compose

# Verify installation
docker-compose --version
```

---

### Step 4: Create Dockerfile

Create a `Dockerfile` in your project directory:

```dockerfile
FROM nginx:latest

# Copy custom HTML (if available)
# COPY html/ /usr/share/nginx/html/

# Or create inline HTML
RUN echo "<h1>🚀 Hello from Custom Nginx Container</h1>" > /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

---

### Step 5: Create docker-compose.yml

Create a `docker-compose.yml` file:

```yaml
version: '3.8'

services:
  nginx-app:
    build: .
    container_name: custom-nginx
    ports:
      - "80:80"
    restart: always
    volumes:
      - ./html:/usr/share/nginx/html:ro
    environment:
      - TZ=UTC
```

---

### Step 6: Run Application

```bash
# Build and start containers in background
docker-compose up -d

# Check running containers
docker ps

# View logs
docker-compose logs -f

# Stop containers (when needed)
docker-compose down
```

---

### Step 7: Access Your Application

1. Get your EC2 Public IP from AWS Console
2. Open browser and navigate to: `http://<EC2-PUBLIC-IP>`
3. You should see: **"🚀 Hello from Custom Nginx Container"**

---

### Step 8: Push Image to Docker Hub (Optional)

```bash
# Login to Docker Hub
docker login

# Build image with tag
docker build -t yourdockerhubusername/custom-nginx:v1 .

# Push to Docker Hub
docker push yourdockerhubusername/custom-nginx:v1

# Verify on Docker Hub dashboard
```

---

### Step 9: Push Code to GitHub

```bash
# Initialize git repository
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: Custom Nginx deployment with Docker"

# Rename branch to main
git branch -M main

# Add remote origin
git remote add origin https://github.com/AshwiniGopinaidu/nginx-custom-deployment.git

# Push to GitHub
git push -u origin main
```

---

## 📄 File Descriptions

### Dockerfile

This file defines how to build the Docker image:

- **FROM nginx:latest**: Uses the official Nginx image as base
- **RUN**: Creates custom HTML or copies files
- **EXPOSE**: Exposes port 80 for HTTP traffic
- **CMD**: Starts Nginx in foreground mode

### docker-compose.yml

Orchestrates container deployment:

- **version**: Specifies Docker Compose format
- **services**: Defines containers to run
- **build**: Builds image from Dockerfile
- **container_name**: Names the running container
- **ports**: Maps host port to container port
- **volumes**: Mounts directories for persistent data
- **restart**: Auto-restart policy

---

## ⚙️ Customization

### Custom HTML Content

Create an `html/` directory with your custom content:

```bash
mkdir html
echo "<h1>Welcome to My Site</h1>" > html/index.html
```

Update Dockerfile:

```dockerfile
COPY html/ /usr/share/nginx/html/
```

Rebuild and restart:

```bash
docker-compose up -d --build
```

### Environment Variables

Add to `docker-compose.yml`:

```yaml
environment:
  - NGINX_HOST=example.com
  - NGINX_PORT=80
```

### Custom Nginx Configuration

Create `nginx.conf` and mount it:

```yaml
volumes:
  - ./nginx.conf:/etc/nginx/nginx.conf:ro
  - ./html:/usr/share/nginx/html:ro
```

### Enable HTTPS/SSL

```yaml
ports:
  - "80:80"
  - "443:443"
volumes:
  - ./ssl:/etc/nginx/ssl:ro
```

---

## 🔧 Troubleshooting

### Issue: "Permission denied" when running docker commands

**Solution**: Re-login or restart your session after adding user to docker group:

```bash
sudo usermod -aG docker $USER
newgrp docker
```

### Issue: Port 80 already in use

**Solution**: Change port mapping in `docker-compose.yml`:

```yaml
ports:
  - "8080:80"  # Access via http://<IP>:8080
```

### Issue: Container exits immediately

**Solution**: Check logs:

```bash
docker-compose logs
docker logs custom-nginx
```

### Issue: Cannot access EC2 instance

**Solution**: 
- Verify security group allows inbound HTTP (80)
- Check EC2 instance is running
- Verify public IP is correct

### Issue: Docker Compose command not found

**Solution**: Reinstall Docker Compose:

```bash
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 \
  -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

---

## 🚀 Advanced Usage

### View Container Logs

```bash
docker-compose logs -f nginx-app
```

### Execute Command in Container

```bash
docker exec -it custom-nginx bash
```

### Rebuild Image

```bash
docker-compose up -d --build
```

### Remove Containers & Volumes

```bash
docker-compose down -v
```

### Health Checks

Add to `docker-compose.yml`:

```yaml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost"]
  interval: 30s
  timeout: 10s
  retries: 3
```

### Resource Limits

```yaml
services:
  nginx-app:
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 512M
```

---

## 🤝 Contributing

Contributions are welcome! To contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 📞 Support

For issues, questions, or suggestions:

- Open an [Issue](https://github.com/AshwiniGopinaidu/nginx-custom-deployment/issues)
- Check existing documentation
- Review Docker & AWS documentation

---

## 📚 Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Nginx Documentation](https://nginx.org/en/docs/)
- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)
- [Docker Hub](https://hub.docker.com/)

---

**Happy Deploying! 🚀**
