uname=$(uname -a)
export NR_LICENSE_KEY="d42e0f214385d45bb811bb096dbf6992e9b50981"
ver=$(cat /etc/debian_version)
echo "== BEGIN: vagrant provisioning on '${uname}'"
echo "== DEBIAN VERSION: ${ver}"
echo "== Installing NR Infrastructure"
echo "license_key: $NR_LICENSE_KEY" | tee -a /etc/newrelic-infra.yml
curl https://download.newrelic.com/infrastructure_agent/gpg/newrelic-infra.gpg | apt-key add -
printf "deb [arch=amd64] http://download.newrelic.com/infrastructure_agent/linux/apt stretch main" | tee -a /etc/apt/sources.list.d/newrelic-infra.list
/usr/bin/apt-get update -y -qq > /dev/null 2>&1
/usr/bin/apt-get install ansible newrelic-infra -y

extip=$(curl -s http://metadata/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip -H "Metadata-Flavor: Google")
echo "== EXTERNAL IP: ${extip}"
echo "== APPENDING /etc/motd"
d=$(date +%r)
echo "# ${d}" >> /etc/motd
echo "== cat /etc/motd"
cat /etc/motd
