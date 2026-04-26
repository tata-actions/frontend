FROM nginx:1.27-alpine

# Remove default configs
RUN rm -f /etc/nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Create required dirs + fix permissions
RUN mkdir -p /var/cache/nginx \
    /var/run \
    /var/log/nginx && \
    chown -R nginx:nginx /var/cache/nginx /var/run /var/log/nginx /etc/nginx

# Copy config + app
COPY nginx.conf /etc/nginx/nginx.conf
COPY static /usr/share/nginx/html/

# Fix static file permissions
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