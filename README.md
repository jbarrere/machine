# machine
docker-machine machine.sh script for Windows.  
Easily manage your docker machines. 

Note: This script was initialized with docker-machine `script.sh`
# configuration
machine.sh variables:

`STORAGE`  
default value: `STORAGE="~/.docker/machine"`  
Change this value to change machine storage folder (docker-machine `-s` option) another folder (ex : `STORAGE="/d/Users/Bob/.docker/machine"`).

`DOCKER_MACHINE_WITH_OPTS`  
default value: `DOCKER_MACHINE_WITH_OPTS="./docker-machine.exe -s $STORAGE"`    
docker-machine options.

`VBOX_HOME`  
default value: `VBOX_HOME="/c/Program Files/Oracle/VirtualBox"`  
VirtualBox installation folder.

`DOCKER_TOOLBOX_HOME`  
default value: `DOCKER_TOOLBOX_HOME="/c/Program Files/Docker Toolbox"`  
Docker Toolbox installation folder.

`DOCKER_CREATE_OPTS`
default value: `DOCKER_CREATE_OPTS="--virtualbox-memory 2048"`  
Docker options for VM creation.

# usage
Start the machine ``dev``. If the machine does not exist, it will be created 
<pre><code>machine.sh dev start</code></pre>

Stop the machine ``dev``
<pre><code>machine.sh dev stop</code></pre>

Open a ssh to machine ``dev``
<pre><code>machine.sh dev ssh</code></pre>

# FAQ

- ``start``  command does not end if VM needs to be created
<pre></code>machine.sh dev-java start
Welcome to Git (version 1.9.5-preview20150319)


Run 'git help git' to display the help index.
Run 'git help <command>' to display help for specific commands.
Creating Machine dev-java...
Creating VirtualBox VM...
Creating SSH key...
Starting VirtualBox VM...
Starting VM...
</code></pre>

Open VirtualBox, and check if the VM is correctly started, then you can ``ssh`` on the new machine.