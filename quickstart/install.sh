#!/bin/bash
if [ "$1" == "dev" ]; then
  echo "Dev build set"
  BUILDMODE="sec555"
else
  BUILDMODE="sec555"
fi

MISSINGSOFTWARE=()
MISSINGSYSCTLSETTINGS=()
MISSINGLIMITSSETTINGS=()
STORAGEPASSWORDS=()
SUDOUSER=`logname`

FILE=/etc/os-release
if [ -f "$FILE" ]; then
    FILECHECK=/etc/os-release
    OSNAME=`cat $FILECHECK | grep ^NAME= | cut -d"=" -f2 | tr -d '"'`
    VERSIONRELEASE=`cat $FILECHECK | grep ^VERSION_ID= | cut -d"=" -f2 | tr -d '"'`
fi
if [ "$OSNAME" == "CentOS Stream" ]; then
  OSNAME="CentOS Linux"
fi

if [ "$OSNAME" != "AlmaLinux" ] && [ "$OSNAME" != "Amazon Linux" ] && [ "$OSNAME" != "CentOS Linux" ] && [ "$OSNAME" != "Ubuntu" ]; then
  echo "Unsupported operating system"
  exit 0
fi

function check_if_software_installed {
  if [ "$OSNAME" == "Ubuntu" ]; then
    if [ $(dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
      MISSINGSOFTWARE+=("$1")
    fi
  else
    if [ $(yum list installed | cut -d " " -f1 | grep -i "$1" | wc -c) -eq 0 ]; then
      MISSINGSOFTWARE+=("$1")
    fi
  fi
}

function check_if_sysctl_setting_exists {
  if ! grep -q "$1" /etc/sysctl.conf ; then
    MISSINGSYSCTLSETTINGS+=("$1=$2")
  fi
}
function check_if_security_limits_setting_exists {
  if ! grep -q "$1" /etc/security/limits.conf ; then
    MISSINGLIMITSSETTINGS+=("$1")
  fi
}
function check_if_docker_repository_installed {
  case $OSNAME in
    "AlmaLinux")
      if [ $(yum repolist | grep -i docker | wc -c) -eq 0 ]; then
        DOCKERREPOINSTALLED=0
      else
        DOCKERREPOINSTALLED=1
      fi
      ;;
    "Amazon Linux")
      if [ $(yum repolist | grep -i docker | wc -c) -eq 0 ]; then
        DOCKERREPOINSTALLED=0
      else
        DOCKERREPOINSTALLED=1
      fi
      ;;
    "CentOS Linux")
      if [ $(yum repolist | grep -i docker | wc -c) -eq 0 ]; then
        DOCKERREPOINSTALLED=0
      else
        DOCKERREPOINSTALLED=1
      fi
      ;;
    "Ubuntu")
      if [ $(ls /etc/apt/sources.list.d/ | grep -i docker | wc -c) -eq 0 ]; then
        DOCKERREPOINSTALLED=0
      else
        DOCKERREPOINSTALLED=1
      fi
      ;;
  esac
}
function install_docker_repository {
  case $OSNAME in
    "AlmaLinux")
      dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
      ;;
    "CentOS Linux")
      yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
      ;;
    "Ubuntu")
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
      sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" --yes
      sudo apt-get update
      ;;
  esac
}
function install_docker_components {
  if grep docker /etc/group | grep -q ${SUDOUSER}; then
    echo "Current user already member of docker group"
  else
    echo "Adding current user to docker group"
    sudo usermod -aG docker ${SUDOUSER}
  fi
  if [ -f /usr/local/bin/docker-compose ]; then
    echo "Docker Compose is already installed"
  else
    echo "Installing Docker Compose"
    sudo curl -L https://github.com/docker/compose/releases/download/v2.4.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
  fi
  systemctl enable docker
  systemctl start docker
}
function install_software {
  if [ "$OSNAME" == "Ubuntu" ]; then
    apt install -y $1
  else
    yum install -y $1
  fi
}
function set_sysctl_setting {
  sudo sysctl -w "$1"
  echo "$1" | sudo tee -a /etc/sysctl.conf
}
function set_limits_conf {
  echo "$1" | sudo tee -a /etc/security/limits.conf
}
function check_if_file_missing {
  if [ ! -f "$INSTALLDIR/$1" ]; then
    echo "Will download https://raw.githubusercontent.com/reflexsoar/reflex-docs/$BUILDMODE/quickstart/$1 into $INSTALLDIR"
  fi
}
function pull_file_if_missing {
  if [ ! -f "$INSTALLDIR/$1" ]; then
    curl https://raw.githubusercontent.com/reflexsoar/reflex-docs/$BUILDMODE/quickstart/$1  --output $INSTALLDIR/$1
  fi
}
function pull_down_reflex_files {
  pull_file_if_missing "custom-opensearch_dashboards.yml"
  pull_file_if_missing "docker-compose.yml"
  pull_file_if_missing "docker-compose2.yml"
  pull_file_if_missing "docker-compose3.yml"
  pull_file_if_missing "nginx.conf"
  pull_file_if_missing "opensearch_dashboards.crt"
  pull_file_if_missing "opensearch_dashboards.key"
  pull_file_if_missing "reflex-ui.crt"
  pull_file_if_missing "reflex-ui.key"
  pull_file_if_missing "internal_users.yml"
  pull_file_if_missing "roles.yml"
  pull_file_if_missing "roles_mapping.yml"
  pull_file_if_missing "action_groups.yml"
  pull_file_if_missing "nodes_dn.yml"
  pull_file_if_missing "whitelist.yml"
  pull_file_if_missing "config.yml"
}
function generate_random_password {
  PASSWORD=$(cat /dev/urandom | tr -dc '[:alnum:]' | fold -w ${1:-25} | head -n 1 | head -c -1)
}

# Create application.conf if it does not exist
function build_application_conf {
  if [ ! -f $INSTALLDIR/application.conf ]; then
    MASTER=$(cat /dev/urandom | tr -dc '[:alnum:]' | fold -w ${1:-512} | head -n 1)
    SECRET_KEY=$(cat /dev/urandom | tr -dc '[:alnum:]' | fold -w ${1:-256} | head -n 1)
    SECURITY_PASSWORD_SALT=$(cat /dev/urandom | tr -dc '[:alnum:]' | fold -w ${1:-256} | head -n 1)
    echo "MASTER_PASSWORD = \"$MASTER\"" > $INSTALLDIR/application.conf
    echo "SECRET_KEY = \"$SECRET_KEY\"" >> $INSTALLDIR/application.conf
    echo "SECURITY_PASSWORD_SALT = \"$SECURITY_PASSWORD_SALT\"" >> $INSTALLDIR/application.conf
  fi
}

echo "Installing htpasswd tool. Trying apache2-utils and httpd-tools. One of these will error"
check_if_software_installed "apache2-utils"
check_if_software_installed "httpd-tools"

function change_storage_password {
  generate_random_password
  case $1 in
    "ADMINHASHCHANGEME")
      STORAGEPASSWORDS+=("admin:$PASSWORD")
      sed -i "s/STORAGEADMINPASSWORD/$PASSWORD/g" $INSTALLDIR/docker-compose.yml
      sed -i "s/STORAGEADMINPASSWORD/$PASSWORD/g" $INSTALLDIR/docker-compose2.yml
      sed -i "s/STORAGEADMINPASSWORD/$PASSWORD/g" $INSTALLDIR/docker-compose3.yml
      ;;
    "KIBANAHASHCHANGEME")
      STORAGEPASSWORDS+=("kibanaserver:$PASSWORD")
      sed -i "s/KIBANAPASSWORDCHANGEME/$PASSWORD/g" $INSTALLDIR/custom-opensearch_dashboards.yml
      ;;
    "KIBANAROHASHCHANGEME")
      STORAGEPASSWORDS+=("kibanaro:$PASSWORD")
      ;;
    "LOGSTASHHASHCHANGEME")
      STORAGEPASSWORDS+=("logstash:$PASSWORD")
      ;;
    "READALLHASHCHANGEME")
      STORAGEPASSWORDS+=("readall:$PASSWORD")
      ;;
    "SNAPSHOTRESTORECHANGEME")
      STORAGEPASSWORDS+=("snapshotrestore:$PASSWORD")
      ;;
  esac

  STORAGEPASSWORD=$(htpasswd -bnBC 10 "" $PASSWORD | tr -d ':\n')
  STORAGEPASSWORD=$(echo $STORAGEPASSWORD | sed 's/\//\\\//g')
  sed -i "s/$1/$STORAGEPASSWORD/g" $INSTALLDIR/internal_users.yml
  sed -i 's/\r//g' $INSTALLDIR/internal_users.yml
}

DEFAULTDIR=$(pwd)"/reflexsoar"
echo "Which directory would you like to be your install dir ($DEFAULTDIR): "
read INSTALLDIR
if [ "$INSTALLDIR" == "" ]; then
  INSTALLDIR=$DEFAULTDIR
fi
mkdir -p $INSTALLDIR

if [[ $OPENSEARCH_JAVA_HEAP && $OPENSEARCH_JAVA_HEAP -ge 4 ]]; then
  echo "OPENSEARCH_JAVA_HEAP=$OPENSEARCH_JAVA_HEAP" > $INSTALLDIR/.env
else
  echo "OPENSEARCH_JAVA_HEAP=4" > $INSTALLDIR/.env
fi
echo "OPENSEARCH_STACK_VERSION=2.7.0" >> $INSTALLDIR/.env

check_if_docker_repository_installed

check_if_software_installed "git"
check_if_software_installed "curl"
check_if_software_installed "jq"
if [ "$OSNAME" == "Amazon Linux" ]; then
  check_if_software_installed "docker"
else
  check_if_software_installed "docker-ce"
fi
if [ ! "$OSNAME" == "Ubuntu" ]; then
  check_if_software_installed "yum-utils"
fi

check_if_sysctl_setting_exists "vm.max_map_count" "262144"

check_if_security_limits_setting_exists "docker - memlock unlimited"
check_if_security_limits_setting_exists "opensearch - nofile 65535"
check_if_security_limits_setting_exists "opensearch - memlock unlimited"
check_if_security_limits_setting_exists "opensearch soft memlock unlimited"
check_if_security_limits_setting_exists "opensearch hard memlock unlimited"
check_if_security_limits_setting_exists "docker - nofile 65535"
check_if_security_limits_setting_exists "docker - memlock unlimited"
check_if_security_limits_setting_exists "docker soft memlock unlimited"
check_if_security_limits_setting_exists "docker hard memlock unlimited"

if [ $DOCKERREPOINSTALLED == 0 ]; then
  echo "Will install docker software repository"
fi

for value in "${MISSINGSOFTWARE[@]}"
do
     echo "Will install $value"
done

for value in "${MISSINGSYSCTLSETTINGS[@]}"
do
     echo "Will add $value to /etc/sysctl.conf"
done
for value in "${MISSINGLIMITSSETTINGS[@]}"
do
     echo "Will add $value to /etc/security/limits.conf"
done

check_if_file_missing "custom-opensearch_dashboards.yml"
check_if_file_missing "docker-compose.yml"
check_if_file_missing "docker-compose2.yml"
check_if_file_missing "docker-compose3.yml"
check_if_file_missing "nginx.conf"
check_if_file_missing "opensearch_dashboards.crt"
check_if_file_missing "opensearch_dashboards.key"
check_if_file_missing "reflex-ui.crt"
check_if_file_missing "reflex-ui.key"
check_if_file_missing "internal_users.yml"
check_if_file_missing "roles.yml"
check_if_file_missing "roles_mapping.yml"
check_if_file_missing "action_groups.yml"
check_if_file_missing "nodes_dn.yml"
check_if_file_missing "whitelist.yml"
check_if_file_missing "config.yml"
check_if_file_missing "tenants.yml"

echo ""
echo "This installation script is to be used at your own discretion. H & A Security Solutions LLC is not responsible for any damages and expresses no warranties for anything related to the use of this installation script. ReflexSOAR comes with no guarantees or warranties of any sorts, either written or implied. All liabilities are assumed by the individual and their respective organization that is using this script. This installation script does not establish highly-available services. No redundancy is provided. Services are provided as-is."
echo ""
echo "For help with professional installation, please contact H & A Security Solutions LLC at info@hasecuritysolutions.com. Also, consider our cloud-hosted SaaS offering with commercial support and services."
echo ""
echo "Below are changes this script is will make:"
echo ""

echo "Would you like to proceed (y/n): "
read USERINPUT
USERINPUT=$(echo "$USERINPUT" | tr '[:upper:]' '[:lower:]')

if [ "$USERINPUT" == "y" ] || [ "$USERINPUT" == "yes" ]; then
  echo "Proceeding with installation"
else
  echo "Installation aborted"
  exit 0
fi

pull_down_reflex_files
mkdir $INSTALLDIR/agent -p
touch $INSTALLDIR/agent/config.txt

if [ ! "$OSNAME" == "Ubuntu" ]; then
  install_software "yum-utils"
fi

if [ "$VERSIONRELEASE" == "7" ] && [ "$OSNAME" == "CentOS Linux" ]; then
  install_software "epel-release"
fi

if [ $DOCKERREPOINSTALLED == 0 ]; then
  install_docker_repository
fi

for value in "${MISSINGSOFTWARE[@]}"
do
  if [ "$value" == "docker-ce" ] && [ "$OSNAME" == "CentOS Linux" ]; then
    yum remove -y buildah cockpit-podman podman podman-catatonit podman-docker
  fi
  install_software "$value"
  if [ "$value" == "docker-ce" ] || [ "$value" == "docker" ]; then
    install_docker_components
  fi
done

for value in "${MISSINGSYSCTLSETTINGS[@]}"
do
  set_sysctl_setting "$value"
done

for value in "${MISSINGLIMITSSETTINGS[@]}"
do
  set_limits_conf "$value"
done

build_application_conf

# Change passwords
change_storage_password "ADMINHASHCHANGEME"
OSPASSWORD=$PASSWORD
change_storage_password "KIBANAHASHCHANGEME"
change_storage_password "KIBANAROHASHCHANGEME"
change_storage_password "LOGSTASHHASHCHANGEME"
change_storage_password "READALLHASHCHANGEME"
change_storage_password "SNAPSHOTRESTORECHANGEME"

REPLACEMENT=$(echo $INSTALLDIR | sed "s@/@\\\/@g")

sed -i "s/INSTALLDIR/$REPLACEMENT/g" $INSTALLDIR/docker-compose.yml
sed -i "s/INSTALLDIR/$REPLACEMENT/g" $INSTALLDIR/docker-compose2.yml
sed -i "s/INSTALLDIR/$REPLACEMENT/g" $INSTALLDIR/docker-compose3.yml

echo "Passwords generated during installation. Please record these. Also, please securely backup $INSTALLDIR. Especially the file $INSTALLDIR\application.conf"
echo ""
for value in "${STORAGEPASSWORDS[@]}"
do
     echo "$value"
done

cd $INSTALLDIR && /usr/local/bin/docker-compose up -d

TIMEOUT=300
TIMER=0
CONTINUE="no"
while [[ $TIMER -le $TIMEOUT ]] && [ "$CONTINUE" == "no" ]; do
  if [ $(docker ps -f health=healthy -f name=opensearch | grep opensearch | wc -c) -eq 0 ]; then
    echo "Waiting on OpenSearch to start"
    sleep 5
    TIMER+=5
  else
    CONTINUE="yes"
  fi
done
if [ $TIMER -eq $TIMEOUT ]; then
  echo "Timed out waiting for OpenSearch to start. There is an issue with the install."
  exit 0
fi

OPENSEARCH_ONLINE=0

while [ $OPENSEARCH_ONLINE -eq 0 ]
do
  OSHEALTH=`curl --insecure -u admin:admin https://localhost:9200/_cat/health?h=status`
  if [ "$OSHEALTH" = "green" ] || [ "$OSHEALTH" = "yellow" ]; then
    OPENSEARCH_ONLINE=1
  else
    sleep 1
  fi
done

docker exec -it opensearch /bin/bash /usr/share/opensearch/plugins/opensearch-security/tools/securityadmin.sh -cd /usr/share/opensearch/plugins/opensearch-security/securityconfig/ -icl -arc -nhnv -cacert /usr/share/opensearch/config/root-ca.pem -cert /usr/share/opensearch/config/kirk.pem -key /usr/share/opensearch/config/kirk-key.pem

cp -f $INSTALLDIR/docker-compose2.yml $INSTALLDIR/docker-compose.yml

TIMER=0
CONTINUE="no"
while [[ $TIMER -le $TIMEOUT ]] && [ "$CONTINUE" == "no" ]; do
  if [ $(docker ps -f health=healthy -f name=reflex-api | grep reflex-api | wc -c) -eq 0 ]; then
    echo "Waiting on Reflex API to start"
    sleep 5
    TIMER+=5
  else
    CONTINUE="yes"
  fi
done
if [ $TIMER -eq $TIMEOUT ]; then
  echo "Timed out waiting for Reflex API to start. There is an issue with the install."
  exit 0
fi

cd $INSTALLDIR && /usr/local/bin/docker-compose up -d

TIMER=0
CONTINUE="no"
while [[ $TIMER -le $TIMEOUT ]] && [ "$CONTINUE" == "no" ]; do
  if [ $(docker ps -f health=healthy -f name=reflex-ui | grep reflex-ui | wc -c) -eq 0 ]; then
    echo "Waiting on Reflex UI to start"
    sleep 5
    TIMER+=5
  else
    CONTINUE="yes"
  fi
done
if [ $TIMER -eq $TIMEOUT ]; then
  echo "Timed out waiting for Reflex UI to start. There is an issue with the install."
  exit 0
fi

sleep 5

RESULT=$(curl -X 'POST' \
  --insecure \
  'https://localhost/api/v2.0/auth/login' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "email": "admin@reflexsoar.com",
  "password": "reflex"
}')

ACCESSTOKEN=$(echo $RESULT | jq .access_token | tr -d '"')
PERSISTENTTOKEN=$(curl -X 'GET' \
  --insecure \
  'https://localhost/api/v2.0/settings/generate_persistent_pairing_token' \
  -H 'accept: application/json' \
  -H "Authorization: Bearer $ACCESSTOKEN")
echo $PERSISTENTTOKEN
PERSISTENTTOKEN=$(echo $PERSISTENTTOKEN | jq .token | tr -d '"')
echo $PERSISTENTTOKEN
sed -i "s/PERSISTENTTOKENGOESHERE/$PERSISTENTTOKEN/g" $INSTALLDIR/docker-compose3.yml
curl -X 'POST' \
  --insecure \
  'https://localhost/api/v2.0/agent_group' \
  -H 'accept: application/json' \
  -H "Authorization: Bearer $ACCESSTOKEN" \
  -H 'Content-Type: application/json' \
  -d '{
  "name": "DefaultAgentGroup",
  "description": "A default agent group created by the quickstart install.sh script",
  "inputs": []
}'
ADMINUUID=$(curl -X 'GET' \
  --insecure \
  'https://localhost/api/v2.0/user/me' \
  -H 'accept: application/json' \
  -H "Authorization: Bearer $ACCESSTOKEN")
ADMINUUID=$(echo $ADMINUUID | jq .uuid | tr -d '"')

generate_random_password

curl -X 'PUT' \
  --insecure \
  "https://localhost/api/v2.0/user/$ADMINUUID" \
  -H 'accept: application/json' \
  -H "Authorization: Bearer $ACCESSTOKEN" \
  -H 'Content-Type: application/json' \
  -d "{
  \"password\": \"$PASSWORD\"
}"
STORAGEPASSWORDS+=("admin@reflexsoar.com:$PASSWORD")

cp -f $INSTALLDIR/docker-compose3.yml $INSTALLDIR/docker-compose.yml

sleep 5

cd $INSTALLDIR && /usr/local/bin/docker-compose up -d

echo "Reflex install complete. You may now access reflex at https://localhost and make custom reports using OpenSearch Dashboards at https://localhost:5601"

echo "Passwords generated during installation. Please record these. Also, please securely backup $INSTALLDIR. Especially the file $INSTALLDIR\application.conf"
echo ""
for value in "${STORAGEPASSWORDS[@]}"
do
     echo "$value"
done

sed -i '/REFLEX_AGENT_PAIR_MODE=true/d' docker-compose.yml
