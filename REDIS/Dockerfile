FROM redis:7.2-alpine

# Install bash and other utilities if needed
RUN apk add --no-cache bash

# Create necessary directories (redis user already exists in base image)
RUN mkdir -p /usr/local/etc/redis /var/lib/redis /var/log/redis && \
    chown -R redis:redis /usr/local/etc/redis /var/lib/redis /var/log/redis

# Copy configuration files
COPY conf/redis.conf /usr/local/etc/redis/redis.conf
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Make entrypoint executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set ownership
RUN chown redis:redis /usr/local/etc/redis/redis.conf /usr/local/bin/entrypoint.sh

# Create data directory and set permissions
VOLUME ["/var/lib/redis"]

# Expose Redis port
EXPOSE 6379

# Switch to redis user
USER redis

# Set working directory
WORKDIR /var/lib/redis

# Use custom entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]