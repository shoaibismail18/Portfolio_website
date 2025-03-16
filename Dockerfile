# Stage 1: Use Alpine to install Nginx and fetch the website code
FROM alpine:latest as builder

# Install necessary packages
RUN apk add --no-cache git nginx

# Clone the GitHub repository
RUN git clone https://github.com/shoaibismail18/Portfolio_website /usr/share/nginx/html

# Stage 2: Use a minimal Debian-based distroless image with Nginx
FROM gcr.io/distroless/base-debian12

# Copy Nginx from the builder stage
COPY --from=builder /usr/sbin/nginx /usr/sbin/nginx
COPY --from=builder /etc/nginx /etc/nginx
COPY --from=builder /usr/share/nginx/html /usr/share/nginx/html

# Copy the custom Nginx config file (ensure this file exists in your project)
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 for web traffic
EXPOSE 80

# Start the Nginx server
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
