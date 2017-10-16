#!/bin/bash -ex

PROJECT_HOME="/opt/multitool/project"
if [ "$1" == "" ];
then
    echo "Missing role"
    exit 1
fi

echo "Installing git"
sudo yum install -y git

if [ -e "$PROJECT_HOME/.git" ];
then
    echo "Updating project in $PROJECT_HOME"
    cd $PROJECT_HOME
    git pull
else
    echo "Installing project in $PROJECT_HOME"
    mkdir $PROJECT_HOME -p
    PROJECT_REPOSITORY_URL="@@REPOSITORY_URL_HTTPS@@"
    git clone --config 'credential.helper=!aws codecommit --region us-east-1 credential-helper $@' --config 'credential.UseHttpPath=true' $PROJECT_REPOSITORY_URL $PROJECT_HOME
fi;

echo "Linking chef repo"
if [ -L "/opt/chef-repo" ];
then
    unlink /opt/chef-repo
fi;
if [ -d "/opt/chef-repo" ];
then
    rm -rf /opt/chef-repo
fi;

ln -s $PROJECT_HOME/src/chef /opt/chef-repo

if [ -d /opt/chef-repo/nodes ]; then
    echo removing nodes
    rm -rf /opt/chef-repo/nodes
fi

TMP_ROLE_FILE="/tmp/multitool-role.json"

# make role file from parameters and chef role
if [ -e "$TMP_ROLE_FILE" ];
then
    echo "Removing existing role file '$TMP_ROLE_FILE'"
    rm -f $TMP_ROLE_FILE
fi

echo "Making chef role"
echo "{" > $TMP_ROLE_FILE
cat /opt/multitool/project/etc/multitool/parameters.json | head -n -1 | tail -n +2 >> $TMP_ROLE_FILE
echo "," >> $TMP_ROLE_FILE
cat /opt/chef-repo/roles/$1.role.json | head -n -1 | tail -n +2 >> $TMP_ROLE_FILE
echo "}" >> $TMP_ROLE_FILE

chef-solo -c /opt/chef-repo/solo.rb -j $TMP_ROLE_FILE

rm -f $TMP_ROLE_FILE

