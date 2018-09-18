#!/bin/bash
#Configuring the yum related environment

#Configuring the basic environment

yum clean all 
yum makecache 
#yum update -y 
yum install vim wget git unzip -y

yum groupinstall "Development Tools"  -y
yum install openssl-devel -y 
#Install the node environment and compose related accounts
userdel hyper
rm -rf /hyper
useradd hyper -d /hyper
su - hyper <<EOF
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
source /hyper/.bashrc
nvm install v8.11.1

EOF
#Configuring the docker related run environment
yum remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2



ls -al /opt/file/rpm|grep rpm| awk '{print $NF}'|while read line
do
	rpm -ivh /opt/file/rpm/$line
done

ls -al /opt/file/rpm|grep rpm| awk '{print $NF}'|while read line
do
        rpm -ivh /opt/file/rpm/$line
done

ls -al /opt/file/rpm|grep rpm| awk '{print $NF}'|while read line
do
        rpm -ivh /opt/file/rpm/$line
done

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

yum install docker-ce -y  
systemctl start docker

mkdir -p  /etc/docker
cat >/etc/docker/daemon.json<<EOF
{
    "registry-mirrors": ["https://registry.docker-cn.com"],
    "dns": ["114.114.114.114"]
}
EOF
systemctl restart docker
#docker-compose env
\cp /opt/file/rpm/docker-compose /usr/local/bin/
#wget -c  https://github.com/docker/compose/releases/download/1.18.0/docker-compose-$(uname -s)-$(uname -m)     -O /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
yum install ansible -y 
gpasswd -a hyper docker
service docker restart
#end
