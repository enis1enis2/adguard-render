FROM ubuntu:22.04

# Install runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Download and extract official AdGuard Home binary
WORKDIR /opt/adguardhome
RUN curl -sSL https://static.adguard.com/adguardhome/release/AdGuardHome_linux_amd64.tar.gz | tar xz --strip-components=1 -C /opt/adguardhome

# Create directory structure and set open permissions
RUN mkdir -p /opt/adguardhome/conf /opt/adguardhome/work && \
    chmod -R 777 /opt/adguardhome

# Copy pre-configured yaml settings
COPY conf/AdGuardHome.yaml /opt/adguardhome/conf/AdGuardHome.yaml

EXPOSE 3000

# Launch AdGuard Home referencing pre-configured settings
CMD ["/opt/adguardhome/AdGuardHome", "-c", "/opt/adguardhome/conf/AdGuardHome.yaml", "-w", "/opt/adguardhome/work", "--no-check-update"]
