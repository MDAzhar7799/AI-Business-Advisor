# ============================================================
# FileGuardian DevOps System — Dockerfile
# Serves the web dashboard using nginx (lightweight alpine)
# Author: MD AZHAR
# ============================================================

# Stage 1: Use official nginx alpine image (smallest footprint)
FROM nginx:alpine

# Metadata labels
LABEL maintainer="MD AZHAR"
LABEL project="FileGuardian DevOps System"
LABEL version="1.1"
LABEL description="Linux File Monitoring & Auto-Backup Dashboard"

# Remove default nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy all project web files into nginx html directory
COPY index.html /usr/share/nginx/html/
COPY style.css  /usr/share/nginx/html/
COPY script.js  /usr/share/nginx/html/

# Copy the shell monitoring script (available inside container for reference)
COPY scripts/monitor_backup.sh /usr/local/bin/monitor_backup.sh
RUN chmod +x /usr/local/bin/monitor_backup.sh

# Expose port 80 for the web dashboard
EXPOSE 80

# Health check — verify nginx is serving
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:80 || exit 1

# Start nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
