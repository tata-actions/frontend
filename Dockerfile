FROM nginx:1.27-alpine

# Remove default configs
RUN rm -f /etc/nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Create ALL required nginx directories + permissions
RUN mkdir -p /var/cache/nginx/client_temp \
    /var/cache/nginx/proxy_temp \
    /var/cache/nginx/fastcgi_temp \
    /var/cache/nginx/uwsgi_temp \
    /var/cache/nginx/scgi_temp \
    /var/run \
    /var/log/nginx \
    /etc/nginx/ssl && \
    chown -R nginx:nginx /var/cache/nginx /var/run /var/log/nginx /etc/nginx && \
    chmod -R 755 /etc/nginx

# Create PID file with correct ownership
RUN touch /var/run/nginx.pid && \
    chown nginx:nginx /var/run/nginx.pid

# Copy configs and static files
COPY nginx.conf /etc/nginx/nginx.conf
COPY static /usr/share/nginx/html/

# Ensure nginx user can read static content
RUN chown -R nginx:nginx /usr/share/nginx/html

# Run as non-root
USER nginx

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

# FROM nginx
# RUN rm -rf /usr/share/nginx/html/index.html
# RUN rm -rf /etc/nginx/nginx.conf
# RUN rm -rf /etc/nginx/conf.d/default.conf
# COPY nginx.conf /etc/nginx/nginx.conf
# COPY static /usr/share/nginx/html/