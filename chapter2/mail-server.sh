# Allow SMTP(Postfix) ports
sudo ufw allow 25/tcp
sudo ufw allow 587/tcp
sudo ufw allow 465/tcp

# Allow IMAP(Dovecot) ports
sudo ufw allow 143/tcp
sudo ufw allow 993/tcp

# Allow HTTP/HTTPS for Roundcube
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp












sudo apt update && sudo apt upgrade -y  # Ensure the system is up-to-date

sudo apt install postfix dovecot-core dovecot-imapd mysql-server php php-mysql php-cli php-intl php-common php-curl php-json php-xml php-mbstring php-pear apache2 roundcube roundcube-core roundcube-mysql roundcube-plugins -y


# Postfix: Mail transfer agent (MTA) for sending emails.
# Dovecot: IMAP server for receiving emails.
# Roundcube: Web-based email client.
# MySQL: Database server for managing email users (optional).

sudo dpkg-reconfigure postfix

# Select Internet Site.
# Enter your mail server's domain (e.g., mail.example.com).

sudo nano /etc/postfix/main.cf


myhostname = mail.example.com
mydestination = $myhostname, localhost.$mydomain, localhost
relayhost =
inet_interfaces = all
inet_protocols = ipv4
home_mailbox = Maildir/


sudo systemctl restart postfix
