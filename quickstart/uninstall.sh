#!/bin/bash
DEFAULTDIR=$(pwd)"/reflexsoar"
echo "Which directory is your current install dir ($DEFAULTDIR): "
read INSTALLDIR
if [ "$INSTALLDIR" == "" ]; then
  INSTALLDIR=$DEFAULTDIR
fi

echo ""
echo "This uninstall script is to be used at your own discretion. H & A Security Solutions LLC is not responsible for any damages and expresses no warranties for anything related to the use of this installation script. ReflexSOAR comes with no guarantees or warranties of any sorts, either written or implied. All liabilities are assumed by the individual and their respective organization that is using this script. This installation script does not establish highly-available services. No redundancy is provided. Services are provided as-is."
echo ""
echo "For help with professional installation, please contact H & A Security Solutions LLC at info@hasecuritysolutions.com. Also, consider our cloud-hosted SaaS offering with commercial support and services."
echo ""
echo "This script will uninstall ReflexSOAR created by install.sh and remove any persistent data stored in docker volumes created by install.sh:"
echo ""

echo "Would you like to proceed (y/n): "
read USERINPUT
USERINPUT=$(echo "$USERINPUT" | tr '[:upper:]' '[:lower:]')

if [ "$USERINPUT" == "y" ] || [ "$USERINPUT" == "yes" ]; then
  echo "Proceeding with uninstall"
else
  echo "Uninstall aborted"
  exit 0
fi

rm -rf reflexsoar
docker rm -f opensearch
docker rm -f opensearch-dashboards
docker rm -f memcached
docker rm -f reflex-agent
docker rm -f reflex-api
docker rm -f reflex-ui
docker volume rm reflexsoar_opensearch-data1

echo "Uninstall complete"