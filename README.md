# easy installer Grafana and Prometheus
What happens in this script, we first download the Prometheus archive from GitHub, create a user, extract the archive, and grant the user rights to the Prometheus executables. After that, we need to create a folder for the Prometheus configuration, and we also give the rights to it to the created user.

In the Prometheus configuration YAML file, as already mentioned, we should specify in targets a list of IP addresses with ports so that Prometheus knows where the node exporters are running. Then we write the configuration file of the Prometheus service.

With Grafana, everything is easier — just add a gpg-key to authenticate the Grafana repository with the package manager, download the stable version of Grafana, update the apt sources and install Grafana. Next, simply restart systemd configuration manager and start Prometheus and Grafana services.

Important to mention: by default, Prometheus runs on TCP port 9090 and Grafana on TCP port 3000. You should also not forget about the network configuration.
