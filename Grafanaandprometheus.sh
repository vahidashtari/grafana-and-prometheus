#!/bin/bash -e
cd /tmp
curl -LO https://github.com/prometheus/prometheus/releases/download/v2.32.1/prometheus-2.32.1.linux-amd64.tar.gz

sudo useradd --no-create-home --shell /bin/false prometheus

tar -xzf prometheus-2.32.1.linux-amd64.tar.gz
sudo mv prometheus-2.32.1.linux-amd64/prometheus /usr/local/bin/
sudo mv prometheus-2.32.1.linux-amd64/promtool /usr/local/bin/

sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool

sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus

sudo mv prometheus-2.32.1.linux-amd64/consoles /etc/prometheus
sudo mv prometheus-2.32.1.linux-amd64/console_libraries /etc/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus

sudo echo -e "global:
  scrape_interval: 15s #default value - 1 minute
  evaluation_interval: 15s #default value - 1 minute.

alerting:
  alertmanagers:
    - static_configs:
        - targets:
          # - alertmanager:9093

scrape_configs:
  - job_name: "prometheus"
    static_configs: 
      - targets: ['INSTANCE_1_IP:NODE_EXPORTER_PORT', 'INSTANCE_2_IP:NODE_EXPORTER_PORT', ..., INSTANCE_N_IP:NODE_EXPORTER_PORT]
" > /etc/prometheus/prometheus.yml 

sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml

sudo echo -e "[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/prometheus.service 

sudo systemctl daemon-reload
sudo systemctl start prometheus

sudo apt-get install -y apt-transport-https
sudo apt-get install -y software-properties-common wget

wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
sudo apt-get update
sudo apt install grafana -y

sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl start grafana-server
