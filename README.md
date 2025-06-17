# Grafana + Prometheus Monitoring Stack for Coolify

This repository contains a simple monitoring stack using Grafana and Prometheus, configured for deployment on Coolify.

## 🗂️ File Structure

```
.
├── docker-compose.yml     # Docker Compose configuration for Grafana and Prometheus
├── prometheus.yml        # Prometheus configuration file
└── README.md            # Documentation and setup instructions
```

## 🚀 Quick Start

1. Clone this repository to your Coolify server
2. Deploy using Coolify:
   - Create a new service in Coolify
   - Select "Docker Compose" as the deployment method
   - Point to this repository
   - Deploy!

## 📦 What's Included

- **Prometheus**: Latest version, configured for basic monitoring
- **Grafana**: Latest version, pre-configured to work with Prometheus

## 🔧 Configuration

### Default Credentials
- Grafana: 
  - Username: `admin`
  - Password: `admin`
  - URL: `http://your-coolify-domain:3000`

### Ports
- Grafana: 3000
- Prometheus: 9090

## 📊 Adding Data Sources

1. Log into Grafana
2. Go to Configuration > Data Sources
3. Add Prometheus data source:
   - URL: `http://prometheus:9090`
   - Access: Server (default)

## 🔄 Updating Configuration

- Prometheus config: Edit `prometheus.yml`
- Grafana config: Edit environment variables in `docker-compose.yml`

## 🧹 Clean Up

To remove the stack:
1. Stop the service in Coolify
2. Remove the service from Coolify dashboard

## ⚠️ Security Notes

- Change default Grafana credentials after first login
- Consider setting up authentication for Prometheus
- Use HTTPS in production environments

🚀 Easy Installer: Grafana + Prometheus (Dockerized)

This setup provides an all-in-one solution to run Prometheus and Grafana using Docker.

⸻

📦 What the Script Does
	1.	Prometheus Installation:
	•	Downloads Prometheus v2.32.1 from GitHub.
	•	Creates a dedicated prometheus user (no login/shell access).
	•	Extracts the archive and installs the prometheus and promtool binaries.
	•	Creates required directories: /etc/prometheus and /var/lib/prometheus.
	•	Assigns ownership of files and directories to the prometheus user.
	•	Adds a default Prometheus configuration file (prometheus.yml), which includes target IPs where node exporters are expected to be running.
	2.	Grafana Installation:
	•	Adds Grafana's GPG key and APT repository.
	•	Updates the system's package list.
	•	Installs the latest stable version of Grafana.
	3.	Startup Behavior:
	•	Prometheus and Grafana are started together using a startup script inside the container.
	•	Prometheus runs on port 9090, and Grafana runs on port 3000.

⸻

⚙️ How to Use

1. Build the Docker image

docker build -t prometheus-grafana .

2. Run the container

docker run -p 9090:9090 -p 3000:3000 prometheus-grafana

3. Access the services
	•	Prometheus: http://localhost:9090
	•	Grafana: http://localhost:3000

⸻

🛠️ Configuration Notes
	•	Prometheus config: You can edit prometheus.yml to list your target node exporters like:

scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ['192.168.1.10:9100', '192.168.1.11:9100']


	•	Grafana access: Default Grafana settings apply. Login with default credentials:
	•	admin / admin (you'll be prompted to change it)
	•	Network: Ensure TCP ports 9090 and 3000 are open and not blocked by firewalls.

⸻

🧼 Clean Up

To stop and remove the container:

docker ps
docker stop <container_id>
docker rm <container_id>


⸻

📌 Reminder

This is a development/demo-friendly setup. For production, consider using Docker Compose, persistent volumes, and separate containers for Prometheus and Grafana.

⸻
