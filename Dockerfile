FROM ubuntu:22.04

# Install runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /opt/adguardhome

# Download and extract the official AdGuard Home release
RUN curl -sSL https://static.adguard.com/adguardhome/release/AdGuardHome_linux_amd64.tar.gz | tar xz --strip-components=1 -C /opt/adguardhome

# Create directory structure and set full executable permissions
RUN mkdir -p /opt/adguardhome/conf /opt/adguardhome/work && \
    chmod -R 777 /opt/adguardhome && \
    chmod +x /opt/adguardhome/AdGuardHome

# Copy pre-configured yaml settings
COPY conf/AdGuardHome.yaml /opt/adguardhome/conf/AdGuardHome.yaml

EXPOSE 3000

# Launch AdGuard Home referencing the explicit configuration
CMD ["/opt/adguardhome/AdGuardHome", "-c", "/opt/adguardhome/conf/AdGuardHome.yaml", "-w", "/opt/adguardhome/work", "--no-check-update"]
