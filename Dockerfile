FROM nginx:1.27-alpine

# Remove default configs
RUN rm -f /etc/nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Update Alpine packages (safe + reduces CVEs)
RUN apk update && apk upgrade --no-cache

# Copy custom config and static files
COPY nginx.conf /etc/nginx/nginx.conf
COPY static /usr/share/nginx/html/

# Fix only required permissions
RUN chown -R nginx:nginx /usr/share/nginx/html /etc/nginx

# Use non-root user
USER nginx

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

# FROM nginx
# RUN rm -rf /usr/share/nginx/html/index.html
# RUN rm -rf /etc/nginx/nginx.conf
# RUN rm -rf /etc/nginx/conf.d/default.conf
# COPY nginx.conf /etc/nginx/nginx.conf
# COPY static /usr/share/nginx/html/