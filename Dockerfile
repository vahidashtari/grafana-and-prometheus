FROM grafana/grafana-oss

USER root

RUN apk update && apk add sudo bash curl

# Setup user first
RUN adduser -D admin \
    && echo "admin:admin" | chpasswd \
    && addgroup admin wheel \
    && sh -c 'echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers'

USER admin

# Copy the script after switching to user
COPY Grafanaandprometheus.sh /home/admin/Grafanaandprometheus.sh
RUN chmod +x /home/admin/Grafanaandprometheus.sh

# Run the script using sudo inside
RUN sudo /home/admin/Grafanaandprometheus.sh
