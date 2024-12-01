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









# 1. Update the System


sudo apt update && sudo apt upgrade -y  # Ensure the system is up-to-date

# 2. Install Required Packages

sudo apt install postfix dovecot-core dovecot-imapd mysql-server php php-mysql php-cli php-intl php-common php-curl php-json php-xml php-mbstring php-pear apache2 roundcube roundcube-core roundcube-mysql roundcube-plugins -y


# Postfix: Mail transfer agent (MTA) for sending emails.
# Dovecot: IMAP server for receiving emails.
# Roundcube: Web-based email client.
# MySQL: Database server for managing email users (optional).



# 3. Configure Postfix

sudo dpkg-reconfigure postfix

# Select Internet Site.
# Enter your mail server's domain (e.g., mail.example.com).

sudo nano /etc/postfix/main.cf

myhostname = winner.cyfamod.com
mydestination = $myhostname, localhost.$mydomain, localhost
relayhost =
inet_interfaces = all
inet_protocols = ipv4
home_mailbox = Maildir/




sudo systemctl restart postfix


# 4. Configure Dovecot
sudo nano /etc/dovecot/conf.d/10-mail.conf

mail_location = maildir:~/Maildir


sudo nano /etc/dovecot/conf.d/10-master.conf

service imap-login {
    inet_listener imap {
        port = 143
    }
}



sudo systemctl restart dovecot


# 5. Set Up MySQL for Roundcube
sudo mysql_secure_installation

CREATE DATABASE roundcube;
CREATE USER 'roundcube_user'@'localhost' IDENTIFIED BY '1ncrease';
GRANT ALL PRIVILEGES ON roundcube.* TO 'roundcube_user'@'localhost';

FLUSH PRIVILEGES;



# 6. Configure Roundcube
sudo nano /etc/roundcube/config.inc.php

$config['db_dsnw'] = 'mysql://roundcube_user:1ncrease@localhost/roundcube';
$config['default_host'] = 'localhost';
$config['smtp_server'] = 'localhost';

sudo systemctl restart apache2



sudo ln -s /usr/share/roundcube /var/www/html/roundcube

sudo chown -R www-data:www-data /usr/share/roundcube
sudo chmod -R 755 /usr/share/roundcube


sudo systemctl restart apache2

# Navigate to http://<server-ip>/roundcube.
