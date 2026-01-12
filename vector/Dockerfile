ARG BUILD_FROM
FROM ${BUILD_FROM}

# Install dependencies
RUN apk add --no-cache curl tar

# Install Vector
ARG VECTOR_VERSION="0.39.0"
ARG BUILD_ARCH

# Set architecture and download Vector
RUN set -eux; \
    case "${BUILD_ARCH}" in \
        amd64)   ARCH='x86_64-unknown-linux-musl' ;; \
        aarch64) ARCH='aarch64-unknown-linux-musl' ;; \
        armv7)   ARCH='armv7-unknown-linux-musleabihf' ;; \
        *)       echo "Unsupported arch: ${BUILD_ARCH}"; exit 1 ;; \
    esac; \
    echo "Downloading Vector ${VECTOR_VERSION} for ${ARCH}..."; \
    curl -sSfL "https://github.com/vectordotdev/vector/releases/download/v${VECTOR_VERSION}/vector-${VECTOR_VERSION}-${ARCH}.tar.gz" \
        -o /tmp/vector.tar.gz; \
    tar xzf /tmp/vector.tar.gz -C /tmp; \
    mv /tmp/vector-${ARCH}/bin/vector /usr/local/bin/vector; \
    chmod +x /usr/local/bin/vector; \
    rm -rf /tmp/vector* 

# Copy root filesystem
COPY rootfs /

# Copy run script
COPY run.sh /
RUN chmod a+x /run.sh

# Create directories
RUN mkdir -p /etc/vector /data/vector

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -sf http://localhost:8686/health || exit 1

CMD [ "/run.sh" ]
