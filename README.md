

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
	•	Adds Grafana’s GPG key and APT repository.
	•	Updates the system’s package list.
	•	Installs the latest stable version of Grafana.
	3.	Startup Behavior:
	•	Prometheus and Grafana are started together using a startup script inside the container.
	•	Prometheus runs on port 9090, and Grafana runs on port 3000.

⸻

🗂️ File Structure

.
├── Dockerfile              # Container setup for Prometheus + Grafana
├── entrypoint.sh           # Starts both services
├── prometheus.yml          # Default Prometheus configuration
└── README.md               # You're reading it!


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
	•	admin / admin (you’ll be prompted to change it)
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
