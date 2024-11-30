sudo apt update
sudo apt install nfs-kernel-server -y  # For Ubuntu/Debian
# sudo yum install nfs-utils -y          # For RHEL/CentOS/AlmaLinux

# Create a Directory for Sharing Create the directory you want to share:
sudo mkdir -p /mnt/nfs_share

# Set Permissions Ensure proper permissions are set for the shared directory:
sudo chown nobody:nogroup /mnt/nfs_share  # For Ubuntu/Debian
# sudo chown nfsnobody:nfsnobody /mnt/nfs_share  # For RHEL-based distros
sudo chmod 777 /mnt/nfs_share  # Grant full access (adjust as needed)


# Configure Exports Add the directory to the NFS exports file:
sudo nano /etc/exports

# Add the following line:
/mnt/nfs_share    *(rw,sync,no_subtree_check)

# rw: Read/write access.
# sync: Ensures changes are written to disk before being accessible.
# no_subtree_check: Improves performance.



# Export the Shared Directory Apply the configuration:
sudo exportfs -arv
sudo exportfs -v

# Start and Enable NFS Service
sudo systemctl start nfs-kernel-server  # Ubuntu/Debian
sudo systemctl enable nfs-kernel-server
# sudo systemctl start nfs-server         # RHEL/CentOS
# sudo systemctl enable nfs-server



# Allow NFS Traffic Through Firewall
sudo ufw allow from <client-ip> to any port nfs
# For firewalld (RHEL-based):
sudo firewall-cmd --add-service=nfs --permanent
sudo firewall-cmd --reload














# On the NFS Client
# Install NFS Client Package
sudo apt update
sudo apt install nfs-common -y  # For Ubuntu/Debian
# sudo yum install nfs-utils -y   # For RHEL/CentOS/AlmaLinux


# Create a Mount Directory
sudo mkdir -p /mnt/nfs_client

# allow port 2049 , 111
# Mount the NFS Share Replace <server-ip> with the IP address of the NFS server:
sudo mount 192.168.1.55:/mnt/nfs_share /mnt/nfs_client


# Verify the Mount
df -h
# You should see the NFS share listed.



# Make the Mount Persistent Add the following line to /etc/fstab:
nano /etc/fstab
192.168.1.55:/mnt/nfs_share   /mnt/nfs_client   nfs   defaults   0   0


# Test the Setup
# Create a file on the NFS server:
echo "NFS Test" | sudo tee /mnt/nfs_share/testfile


# Verify it appears on the client:
cat /mnt/nfs_client/testfile
