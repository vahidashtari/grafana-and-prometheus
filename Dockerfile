FROM grafana/grafana-oss

USER root

# Copy the script into the container
COPY Grafanaandprometheus.sh /Grafanaandprometheus.sh

# Make it executable
RUN chmod +x /Grafanaandprometheus.sh

# Run the script (installs/configures Grafana/Prometheus)
RUN /Grafanaandprometheus.sh

# Optionally create a sudo user too
RUN apk add sudo bash \
    && adduser -D admin \
    && echo "admin:admin" | chpasswd \
    && addgroup admin wheel \
    && sh -c 'echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers'

USER admin
