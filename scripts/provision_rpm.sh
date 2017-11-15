uname=$(uname -a)
export NR_LICENSE_KEY="d42e0f214385d45bb811bb096dbf6992e9b50981"
ver=$(cat /etc/centos-release)
echo "== BEGIN: vagrant provisioning on '${uname}'"
echo "== OS VERSION: ${ver}"
echo "== Installing Epel Release Repo"
sudo yum install -y epel-release
echo "== Installing NR Infrastructure"
sudo curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/el/7/x86_64/newrelic-infra.repo
sudo yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'
sudo yum install -y newrelic-infra
sudo systemctl enable newrelic-infra
echo "license_key: $NR_LICENSE_KEY" | tee -a /etc/newrelic-infra.yml

# integration-infra
sudo curl -o /etc/yum.repos.d/integration-infra.repo http://ci-poc.vmucuge-test.tk:81/repo/integration.repo
sudo yum -q makecache -y --enablerepo='*'
sudo yum -y install foldersize_integration

# Extras provision and automation
sudo yum install -y ansible
sudo yum install -y https://releases.hashicorp.com/vagrant/2.0.1/vagrant_2.0.1_x86_64.rpm

# GCP Specifics
extip=$(curl -s http://metadata/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip -H "Metadata-Flavor: Google")
echo "== EXTERNAL IP: ${extip}"
echo "== APPENDING /etc/motd"
d=$(date +%r)
echo "# ${d}" >> /etc/motd
echo "== cat /etc/motd"
cat /etc/motd
