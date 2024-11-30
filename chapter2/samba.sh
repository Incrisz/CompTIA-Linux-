sudo apt install samba -y  # Install Samba

sudo smbpasswd -a incrisz  # Add a Samba user
sudo smbpasswd -e incrisz  # Enable the Samba user

sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.old  # Backup the original configuration


sudo nano /etc/samba/smb.conf  # Edit the new configuration

[global] 
 server role = standalone server
 map to guest = bad user  # Allow guest access for invalid users
 usershare allow guests = yes
 hosts allow = 192.168.0.0/16  # Restrict access to the subnet
 hosts deny = 0.0.0.0/0        # Deny access from other IPs

[linuxsharename]
  comment = Open Linux Share
  path = /home
  read only = no  # Allow write access
  guest ok = yes  # Allow guest users
  force user = incrisz  # Force access under the specified user
  force group = incrisz # Force access under the specified group




testparm  # Validate the Samba configuration

sudo systemctl enable smbd  # Enable Samba at startup
sudo systemctl start smbd   # Start the Samba service


\\[Linux-IP]  # Example: \\192.168.0.153
