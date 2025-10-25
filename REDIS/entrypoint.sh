#!/bin/bash
set -e

# Create directories in user-accessible locations
mkdir -p /var/lib/redis/logs

# Set Redis password from environment variable if provided
if [ -n "$REDIS_PASSWORD" ]; then
    echo "" >> /usr/local/etc/redis/redis.conf
    echo "requirepass $REDIS_PASSWORD" >> /usr/local/etc/redis/redis.conf
fi

# Set max memory from environment variable if provided
if [ -n "$REDIS_MAX_MEMORY" ]; then
    sed -i "s/maxmemory 256mb/maxmemory $REDIS_MAX_MEMORY/g" /usr/local/etc/redis/redis.conf
fi

# Set max memory policy from environment variable if provided
if [ -n "$REDIS_MAX_MEMORY_POLICY" ]; then
    sed -i "s/maxmemory-policy allkeys-lru/maxmemory-policy $REDIS_MAX_MEMORY_POLICY/g" /usr/local/etc/redis/redis.conf
fi

# Set number of databases from environment variable if provided
if [ -n "$REDIS_DATABASES" ]; then
    sed -i "s/databases 16/databases $REDIS_DATABASES/g" /usr/local/etc/redis/redis.conf
fi

# Set appendonly from environment variable if provided
if [ -n "$REDIS_APPENDONLY" ]; then
    sed -i "s/appendonly yes/appendonly $REDIS_APPENDONLY/g" /usr/local/etc/redis/redis.conf
fi

# Set appendfsync from environment variable if provided
if [ -n "$REDIS_APPENDFSYNC" ]; then
    sed -i "s/appendfsync everysec/appendfsync $REDIS_APPENDFSYNC/g" /usr/local/etc/redis/redis.conf
fi

echo "Starting Redis with custom configuration..."
echo "Redis configuration loaded from: /usr/local/etc/redis/redis.conf"

# Execute the main command
exec "$@"