#!/bin/bash
# Start Prometheus
/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus/ \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries &

# Start Grafana
/usr/sbin/grafana-server --homepath=/usr/share/grafana &

# Wait
wait
