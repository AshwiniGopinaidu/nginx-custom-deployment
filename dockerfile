FROM nginx:latest
# Custom modification (e.g., adding a simple landing page)
RUN echo "<h1>Custom Nginx on AWS EC2</h1>" > /usr/share/nginx/html/index.html
