# Use Alpine as a lightweight builder to fetch the code
FROM alpine:latest as builder

# Install Git and Nginx
RUN apk add --no-cache git nginx

# Clone the GitHub repository
RUN git clone https://github.com/shoaibismail18/Portfolio_website /usr/share/nginx/html

# Use a distroless image for final production
FROM gcr.io/distroless/static:nonroot

# Copy Nginx binary and website files from builder stage
COPY --from=builder /usr/sbin/nginx /usr/sbin/nginx
COPY --from=builder /usr/share/nginx /usr/share/nginx

# Copy the Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 for web traffic
EXPOSE 80

# Start Nginx server
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
