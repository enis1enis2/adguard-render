FROM adguard/adguardhome:latest

# Create working directories with full non-root permissions
RUN mkdir -p /opt/adguardhome/conf /opt/adguardhome/work && \
    chmod -R 777 /opt/adguardhome

# Copy pre-configured yaml settings
COPY conf/AdGuardHome.yaml /opt/adguardhome/conf/AdGuardHome.yaml

# Override entrypoint to launch directly without system/root checks
ENTRYPOINT []
CMD ["/opt/adguardhome/AdGuardHome", "-c", "/opt/adguardhome/conf/AdGuardHome.yaml", "-w", "/opt/adguardhome/work", "--no-check-update"]
