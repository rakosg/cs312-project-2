#!/bin/bash
 sudo su

yum update -y
yum install -y java-21-amazon-corretto-headless

useradd minecraft
mkdir -p /opt/minecraft/server
wget -O /opt/minecraft/server/server.jar https://piston-data.mojang.com/v1/objects/145ff0858209bcfc164859ba735d4199aafa1eea/server.jar
sed -i 's/false/true/p' /opt/minecraft/server/eula.txt

cd /opt/minecraft/server
touch start.sh
touch stop.sh
chmod +x start.sh stop.sh
printf '#!/bin/bash\njava -Xmx1024M -Xms1024M -jar server.jar nogui' > start.sh
printf '#!/bin/bash\nkill -9 $(\\psi-ef | pgrep -f \"java\")' > stop.sh

chown -R minecraft:minecraft /opt/minecraft

cd /etc/systemd/system
touch minecraft.service
printf '[Unit]\nDescription=Minecraft Server\nAfter=network.target\n[Service]\nUser=minecraft\nWorkingDirectory=/opt/minecraft/server\nExecStart=/opt/minecraft/server/start.sh\nExecStop=/bin/kill -s SIGINT $MAINPID\nRestart=on-failure\n[Install]\nWantedBy=multi-user.target' > minecraft.service

systemctl daemon-reload
systemctl enable minecraft.service
systemctl start minecraft.service
systemctl status minecraft.service

exit
