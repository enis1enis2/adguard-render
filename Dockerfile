FROM adguard/adguardhome:latest

# Ensure binary and directory permissions are executable by non-root users
RUN chmod -R 777 /opt/adguardhome

# Run AdGuardHome without elevated net-caps requirements
CMD ["/opt/adguardhome/AdGuardHome", "--no-check-update", "-c", "/opt/adguardhome/conf/AdGuardHome.yaml", "-w", "/opt/adguardhome/work"]
