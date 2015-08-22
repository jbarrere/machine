#!/bin/bash
# initial script is Docker Toolbox start.sh

trap '[ "$?" -eq 0 ] || read -p "Looks like something went wrong... Press any key to continue..."' EXIT
# #########################################################
# variables
STORAGE="~/.docker/machine"
DOCKER_MACHINE_WITH_OPTS="./docker-machine.exe -s $STORAGE"
VBOX_HOME="/c/Program Files/Oracle/VirtualBox"
DOCKER_TOOLBOX_HOME="/c/Program Files/Docker Toolbox"
DOCKER_CREATE_OPTS="--virtualbox-memory 2048"

BLUE='\033[1;34m'
GREEN='\033[0;32m'
NC='\033[0m'

# #########################################################
createmachine () {
  if [ $VM_EXISTS_CODE -eq 1 ]; then
    echo "Creating Machine $1..."
    cd "$DOCKER_TOOLBOX_HOME"
    $DOCKER_MACHINE_WITH_OPTS rm -f $1 &> /dev/null || :
    rm -rf $STORAGE/machines/$1
    $DOCKER_MACHINE_WITH_OPTS create -d virtualbox $DOCKER_CREATE_OPTS $1
  else
    echo "Machine $1 already exists in VirtualBox."
  fi
}

# ##########################
startmachine () {
  echo "Starting machine $1..."
  cd "$DOCKER_TOOLBOX_HOME"
  $DOCKER_MACHINE_WITH_OPTS start $1

  echo "Setting environment variables for machine $1..."
  eval "$($DOCKER_MACHINE_WITH_OPTS env $1)"

  clear
  echo ""
  echo ""
  echo "                          ##         ."
  echo "                    ## ## ##        =="
  echo "                 ## ## ## ## ##    ==="
  echo "             /"""""""""""""""""\___/ ===""
  echo "        ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~"
  echo "             \______ o           __/"
  echo "               \    \         __/"
  echo "                \____\_______/"

  echo -e "${BLUE}docker${NC} is configured to use the ${GREEN}$1${NC} machine with IP ${GREEN}$($DOCKER_MACHINE_WITH_OPTS ip $1)${NC}"
  echo "For help getting started, check out the docs at https://docs.docker.com"
  echo
  cd

  exec "$BASH" --login -i
}

# ##########################
stopmachine () {
  echo "Stopping machine $1..."
  cd "$DOCKER_TOOLBOX_HOME"
  $DOCKER_MACHINE_WITH_OPTS stop $1
}

# ##########################
sshmachine () {
  echo "Starting SSH to $VM..."
  cd "$DOCKER_TOOLBOX_HOME"
  $DOCKER_MACHINE_WITH_OPTS ssh $VM
}

# #########################################################
main () {
    VM=$1
    "$VBOX_HOME/VBoxManage.exe" showvminfo $VM &> /dev/null
    VM_EXISTS_CODE=$?
    set -e
    if [ "$2" = "start" ]; then
        createmachine $VM
        startmachine $VM
    elif [ "$2" = "stop" ]; then
        stopmachine $VM
    elif [ "$2" = "ssh" ]; then
        sshmachine $VM
    else
        echo "unknown parameter $2"
        usage
    fi
}

# ##########################
usage () {
    APP_NAME=${0##*\\} 
    echo ""
    echo "usage: $APP_NAME <machine> [start|stop|ssh]"
    echo ""
    echo "example:"
    echo "> $APP_NAME dev start"
    echo "> $APP_NAME dev stop"
    echo "> $APP_NAME dev ssh"
    exit 0
}

# #########################################################
if [ "$#" -ne 2 ]; then
    usage
fi

if [ ! -f "$DOCKER_TOOLBOX_HOME/docker-machine.exe" ]; then
    echo "Docker Machine is not installed. Please re-run the Toolbox Installer"
    exit 1
fi

if [ ! -f "$VBOX_HOME/VBoxManage.exe" ]; then
    echo "VirtualBox is not installed. Please re-run the Toolbox Installer or VirtualBox Installer"
    exit 2
fi
main $1 $2

