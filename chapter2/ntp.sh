# 1. Install NTP(network time protocol)
sudo apt update
sudo apt install ntp -y  # For Ubuntu/Debian
# sudo yum install ntp -y  # For CentOS/RHEL

# 2. Configure the NTP Server
# Edit the NTP configuration file:
sudo nano /etc/ntp.conf

server 0.pool.ntp.org iburst
server 1.pool.ntp.org iburst
server 2.pool.ntp.org iburst
server 3.pool.ntp.org iburst
# Allow Client Access: Add the following lines to allow access to your local network:
restrict 192.168.1.0 mask 255.255.255.0 nomodify notrap


# 3. Start and Enable the NTP Service
sudo systemctl restart ntp    # For Ubuntu/Debian
# sudo systemctl restart ntpd   # For CentOS/RHEL

sudo systemctl enable ntp     # Enable at startup (Ubuntu/Debian)
# sudo systemctl enable ntpd    # Enable at startup (CentOS/RHEL)

# 4. Check the NTP Service
ntpq -p

# 5. Allow NTP Through Firewall
sudo ufw allow 123/udp         # Ubuntu/Debian
# sudo firewall-cmd --add-service=ntp --permanent  # CentOS/RHEL
sudo firewall-cmd --reload


# 6. Configure Clients to Use the NTP Server
sudo nano /etc/ntp.conf

server <NTP-server-IP> iburst

server 192.168.1.23 iburst

sudo systemctl restart ntp
