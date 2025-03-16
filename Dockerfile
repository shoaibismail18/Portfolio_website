# Use Nginx Alpine as a lightweight base image
FROM nginx:alpine as builder

# Remove default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Clone the GitHub repository directly into the web server directory
RUN apk add --no-cache git && \
    git clone https://github.com/shoaibismail18/Portfolio_website /usr/share/nginx/html

# Use a distroless image for final production
FROM gcr.io/distroless/static:nonroot

# Copy the Nginx binary and static website files from the builder stage
COPY --from=builder /usr/sbin/nginx /usr/sbin/nginx
COPY --from=builder /usr/lib /usr/lib
COPY --from=builder /usr/share/nginx/html /usr/share/nginx/html
COPY --from=builder /etc/nginx /etc/nginx

# Expose port 80 for web traffic
EXPOSE 80

# Start Nginx server
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
