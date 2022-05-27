yum update
yum install -y epel-release
yum install -y vim wget zip yum-utils net-tools gcc-c++ make chrony jq
echo "==================================================================="
echo "base requirement installed"
echo "==================================================================="
yum -y install https://packages.endpoint.com/rhel/7/os/x86_64/endpoint-repo-1.7-1.x86_64.rpm
yum -y install git
echo "==================================================================="
echo "git installed"
echo "==================================================================="
git config --global credential.helper store
echo "==================================================================="
echo "git configured"
echo "==================================================================="
timedatectl set-timezone Asia/Tehran
timedatectl set-ntp on
systemctl enable --now chronyd
chronyc sources
chronyc activity
timedatectl
echo "==================================================================="
echo "server time updated"
echo "==================================================================="
cat > /etc/yum.repos.d/nginx.repo <<EOL
[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/7/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
EOL
echo "==================================================================="
echo "nginx config set"
echo "==================================================================="
yum install -y nginx
service nginx start
chkconfig nginx on
echo "==================================================================="
echo "nginx installed"
echo "==================================================================="
curl -sL https://rpm.nodesource.com/setup_lts.x | bash -
curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo
yum install -y nodejs yarn
echo "==================================================================="
echo "nodejs installed"
echo "==================================================================="
npm i -g pm2 typescript
echo "==================================================================="
echo "pm2 typescript"
echo "==================================================================="
npm i -g gulp gulp-cli bower
echo "==================================================================="
echo "gulp gulp-cli bower installed"
echo "==================================================================="
cat > /etc/yum.repos.d/mongodb-org-4.4.repo <<EOL
[mongodb-org-4.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/4.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.4.asc
EOL
echo "==================================================================="
echo "mongodb config"
echo "==================================================================="
yum install -y mongodb-org
echo "==================================================================="
echo "mongodb installed"
echo "==================================================================="
systemctl start mongod
chkconfig mongod on
echo "==================================================================="
echo "mongodb start"
echo "==================================================================="
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --permanent --add-port=3000/tcp
firewall-cmd --permanent --add-port=3001/tcp
firewall-cmd --permanent --add-port=3002/tcp
firewall-cmd --reload
echo "==================================================================="
echo "firewall config open tcp port on 3000 | 3001 | 3002"
echo "==================================================================="
