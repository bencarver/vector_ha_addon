#!/usr/bin/with-contenv bashio
set -e

# Read configuration options
CONFIG_PATH=$(bashio::config 'config_path')
API_ENABLED=$(bashio::config 'api_enabled')
API_ADDRESS=$(bashio::config 'api_address')
LOG_LEVEL=$(bashio::config 'log_level')
BETTERSTACK_TOKEN=$(bashio::config 'betterstack_token')

# Create required directories
if [ ! -d "/config/vector" ]; then
    bashio::log.info "Creating Vector config directory..."
    mkdir -p /config/vector
fi

if [ ! -d "/data/vector" ]; then
    bashio::log.info "Creating Vector data directory..."
    mkdir -p /data/vector
fi

# Copy default config if user config doesn't exist
if [ ! -f "${CONFIG_PATH}" ]; then
    bashio::log.info "Creating default Vector configuration..."
    cp /etc/vector/vector.yaml "${CONFIG_PATH}"
fi

# Build Vector arguments
VECTOR_ARGS="--config ${CONFIG_PATH}"

# Set environment variables
export VECTOR_LOG="${LOG_LEVEL}"
export BETTERSTACK_TOKEN="${BETTERSTACK_TOKEN}"

bashio::log.info "Starting Vector..."
bashio::log.info "Config: ${CONFIG_PATH}"
bashio::log.info "Log Level: ${LOG_LEVEL}"

if [ -n "${BETTERSTACK_TOKEN}" ] && [ "${BETTERSTACK_TOKEN}" != "null" ]; then
    bashio::log.info "Betterstack: Enabled"
else
    bashio::log.warning "Betterstack: Token not configured - logs will only output to console"
fi

# Validate configuration
bashio::log.info "Validating Vector configuration..."
if ! /usr/local/bin/vector validate "${CONFIG_PATH}"; then
    bashio::log.error "Invalid Vector configuration!"
    exit 1
fi

# Start Vector
exec /usr/local/bin/vector ${VECTOR_ARGS}
