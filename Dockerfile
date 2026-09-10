FROM ubuntu:22.04

# Install dependencies required by AdGuard Home
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Download and extract official AdGuard Home binary directly
WORKDIR /opt/adguardhome
RUN curl -sSL https://static.adguard.com/adguardhome/release/AdGuardHome_linux_amd64.tar.gz | tar xz --strip-components=1 -C /opt/adguardhome

# Pre-create required directory structure with global permissions
RUN mkdir -p /opt/adguardhome/conf /opt/adguardhome/work && \
    chmod -R 777 /opt/adguardhome

EXPOSE 3000

# Launch directly without root checks or privileged socket binding
CMD ["/opt/adguardhome/AdGuardHome", "-c", "/opt/adguardhome/conf/AdGuardHome.yaml", "-w", "/opt/adguardhome/work", "--no-check-update"]
