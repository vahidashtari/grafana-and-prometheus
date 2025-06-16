FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl wget gnupg apt-transport-https software-properties-common

# Create Prometheus user
RUN useradd --no-create-home --shell /bin/false prometheus

# Install Prometheus
WORKDIR /tmp
RUN curl -LO https://github.com/prometheus/prometheus/releases/download/v2.32.1/prometheus-2.32.1.linux-amd64.tar.gz && \
    tar -xzf prometheus-2.32.1.linux-amd64.tar.gz && \
    mv prometheus-2.32.1.linux-amd64/prometheus /usr/local/bin/ && \
    mv prometheus-2.32.1.linux-amd64/promtool /usr/local/bin/ && \
    mkdir -p /etc/prometheus /var/lib/prometheus && \
    mv prometheus-2.32.1.linux-amd64/consoles /etc/prometheus && \
    mv prometheus-2.32.1.linux-amd64/console_libraries /etc/prometheus && \
    chown -R prometheus:prometheus /usr/local/bin/prometheus /usr/local/bin/promtool /etc/prometheus /var/lib/prometheus

# Add Prometheus config
COPY prometheus.yml /etc/prometheus/prometheus.yml
RUN chown prometheus:prometheus /etc/prometheus/prometheus.yml

# Install Grafana
RUN wget -q -O - https://packages.grafana.com/gpg.key | apt-key add - && \
    add-apt-repository "deb https://packages.grafana.com/oss/deb stable main" && \
    apt-get update && \
    apt-get install -y grafana

# Expose web ports
EXPOSE 9090 3000

# Add entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]