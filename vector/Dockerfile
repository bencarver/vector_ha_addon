ARG BUILD_FROM
FROM ${BUILD_FROM}

# Install dependencies
RUN apk add --no-cache \
    curl \
    tar \
    ca-certificates

# Vector version
ENV VECTOR_VERSION="0.42.0"

# Build argument for architecture
ARG BUILD_ARCH=amd64

# Download and install Vector
RUN set -ex; \
    case "${BUILD_ARCH}" in \
        amd64)   ARCH='x86_64-unknown-linux-musl' ;; \
        aarch64) ARCH='aarch64-unknown-linux-musl' ;; \
        armv7)   ARCH='armv7-unknown-linux-musleabihf' ;; \
        i386)    echo "i386 not supported"; exit 1 ;; \
        *)       echo "Unknown arch: ${BUILD_ARCH}"; exit 1 ;; \
    esac; \
    DOWNLOAD_URL="https://github.com/vectordotdev/vector/releases/download/v${VECTOR_VERSION}/vector-${VECTOR_VERSION}-${ARCH}.tar.gz"; \
    echo "Downloading: ${DOWNLOAD_URL}"; \
    curl -sSfL "${DOWNLOAD_URL}" -o /tmp/vector.tar.gz; \
    cd /tmp && tar xzf vector.tar.gz; \
    ls -la /tmp/; \
    mv "/tmp/vector-${ARCH}/bin/vector" /usr/local/bin/vector; \
    chmod +x /usr/local/bin/vector; \
    /usr/local/bin/vector --version; \
    rm -rf /tmp/vector*

# Copy root filesystem
COPY rootfs /

# Copy run script
COPY run.sh /
RUN chmod a+x /run.sh

# Create directories
RUN mkdir -p /etc/vector /data/vector

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD curl -sf http://localhost:8686/health || exit 1

CMD [ "/run.sh" ]
