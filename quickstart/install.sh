#!/bin/bash
if [ "$1" == "dev" ]; then
  echo "Dev build set"
  BUILDMODE="dev"
else
  BUILDMODE="main"
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
  pull_file_if_missing "nginx.conf"
  pull_file_if_missing "opensearch_dashboards.crt"
  pull_file_if_missing "opensearch_dashboards.key"
  pull_file_if_missing "reflex-ui.crt"
  pull_file_if_missing "reflex-ui.key"
  pull_file_if_missing "internal_users.yml"
  pull_file_if_missing "roles.yml"
  pull_file_if_missing "roles_mapping.yml"
}
function generate_random_password {
  PASSWORD=$(cat /dev/urandom | tr -dc '[:alnum:]' | fold -w ${1:-25} | head -n 1)
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
function change_storage_password {
  generate_random_password
  case $1 in
    "ADMINHASHCHANGEME")
      STORAGEPASSWORDS+=("admin:$PASSWORD")
      ;;
    "KIBANAHASHCHANGEME")
      STORAGEPASSWORDS+=("kibanaserver:$PASSWORD")
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

  STORAGEPASSWORD=$(docker run -it --rm -e JAVA_HOME=/usr/share/opensearch/jdk opensearchproject/opensearch:1.3.1 /bin/bash /usr/share/opensearch/plugins/opensearch-security/tools/hash.sh -p $PASSWORD)
  STORAGEPASSWORD=$(echo $STORAGEPASSWORD | sed 's/\//\\\//g')
  sed -i "s/$1/$STORAGEPASSWORD/g" $INSTALLDIR/internal_users.yml
}

DEFAULTDIR=$(pwd)"/reflexsoar"
echo "Which directory would you like to be your install dir ($DEFAULTDIR): "
read INSTALLDIR
if [ "$INSTALLDIR" == "" ]; then
  INSTALLDIR=$DEFAULTDIR
fi
mkdir -p $INSTALLDIR

check_if_docker_repository_installed

check_if_software_installed "git"
check_if_software_installed "curl"
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
check_if_file_missing "nginx.conf"
check_if_file_missing "opensearch_dashboards.crt"
check_if_file_missing "opensearch_dashboards.key"
check_if_file_missing "reflex-ui.crt"
check_if_file_missing "reflex-ui.key"

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

if [ ! "$OSNAME" == "Ubuntu" ]; then
  install_software "yum-utils"
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
change_storage_password "KIBANAHASHCHANGEME"
change_storage_password "KIBANAROHASHCHANGEME"
change_storage_password "LOGSTASHHASHCHANGEME"
change_storage_password "READALLHASHCHANGEME"
change_storage_password "SNAPSHOTRESTORECHANGEME"

cd $INSTALLDIR && /usr/local/bin/docker-compose up -d

echo "Reflex install complete"

echo "Passwords generated during installation. Please record these. Also, please securely backup $INSTALLDIR. Especially the file $INSTALLDIR\application.conf"
echo ""
for value in "${STORAGEPASSWORDS[@]}"
do
     echo "$value"
done
