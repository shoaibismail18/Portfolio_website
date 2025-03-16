# Use an official Nginx image based on Alpine
FROM nginx:alpine

# Remove default nginx config and add a custom one
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf

# Copy website files (ensure they exist in your local directory)
COPY . /usr/share/nginx/html

# Expose port 80 for web traffic
EXPOSE 80

# Start Nginx server in the foreground
CMD ["nginx", "-g", "daemon off;"]
