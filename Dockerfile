  UW PICO 5.09                           New Buffer





















                                  [ New file ]
^G Get Help  ^O WriteOut  ^R Read File ^Y Prev Pg   ^K Cut Text  ^C Cur Pos
^X Exit      ^J Justify   ^W Where is  ^V Next Pg   ^U UnCut Text^T To Spell
  UW PICO 5.09                           New Buffer





















                               [ Read 20 lines ]
^G Get Help  ^O WriteOut  ^R Read File ^Y Prev Pg   ^K Cut Text  ^C Cur Pos
^X Exit      ^J Justify   ^W Where is  ^V Next Pg   ^U UnCut Text^T To Spell
  UW PICO 5.09                    File: Dockerfile                    Modified


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


^G Get Help  ^O WriteOut  ^R Read File ^Y Prev Pg   ^K Cut Text  ^C Cur Pos
^X Exit      ^J Justify   ^W Where is  ^V Next Pg   ^U UnCut Text^T To Spell
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
