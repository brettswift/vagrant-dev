#!/bin/bash


PE_PATH="/tmp/puppet/pe/"
PUPPET_VERSION="3.1.0"
PUPPET_FULLNAME="puppet-enterprise-$PUPPET_VERSION-el-6-x86_64"
PUPPET_FILE="$PUPPET_FULLNAME.tar.gz"
WORKING_DIR="/tmp/puppetbootstrap"

cd $WORKING_DIR

echo Determining if I should run the puppet bootstrap....
IS_PUPPET_INSTALLED=false

type puppet >/dev/null 2>&1  && IS_PUPPET_INSTALLED=true

echo Is puppet installed: $IS_PUPPET_INSTALLED

# if $IS_PUPPET_INSTALLED ; then
if [ -f /usr/local/bin/puppet ]; then
  echo puppet is already installed.... skipping.... 
else
    echo puppet not found,  installing:  $PUPPET_FULLNAME
    #install puppet
    if [ ! -e "$WORKING_DIR/$PUPPET_FILE" ]; then
      echo "downloading puppet to: $WORKING_DIR/$PUPPET_FILE"
      wget -nv -c "$PE_PATH/$PUPPET_FILE"
    else
      echo "already downloaded"
    fi

    if [ ! -d "$WORKING_DIR/$PUPPET_FULLNAME" ]; then
      echo 'unzipping'
      tar -zxvf $PUPPET_FILE
    else
      echo "already unzipped"
    fi

    # puppet-enterprise-installer
    # setup answers file
    `cp answers.master.template answers.master`

    HOST=$(hostname -s)
    FQDN=$(hostname)
    #remove '%= ' and ' %' first, because i couldn't figure out a single regex (escaping problem for: <...@fqdn..> ? )
    perl -pi -e 's/%= //g'  $WORKING_DIR/answers.master
    perl -pi -e 's/ %//g'  $WORKING_DIR/answers.master
    perl -pi -e "s/\<\@fqdn>/$FQDN/g"  $WORKING_DIR/answers.master
    perl -pi -e "s/\<\@hostname>/$HOST/g"  $WORKING_DIR/answers.master


    # echo install puppet
    $WORKING_DIR/$PUPPET_FULLNAME/puppet-enterprise-installer -a ./answers.master

    # (Brett)  Not sure why these are required so far.  Maybe Bryan does?
    ln -s /opt/puppet/bin/puppet /usr/local/sbin/puppet
    ln -s /opt/environments /etc/puppetlabs/puppet/environments


    # run the bootstrap manifest
    # /usr/local/bin/puppet apply --modulepath=/vagrant/modules /vagrant/modules/puppet/manifests/bootstrap-master.pp --environment master --detailed-exitcodes --verbose --trace --debug

fi


# sudo rm -rf /etc/puppetlabs/puppet/hiera.yaml /etc/hiera.yaml
# ln -s /vagrant/modules/puppet/files/hiera.yaml /etc/puppetlabs/puppet/hiera.yaml
# ln -s /vagrant/modules/puppet/files/hiera.yaml /etc/hiera.yaml

#TESTING - remove this as it should run above
    # /usr/local/bin/puppet apply --modulepath=/vagrant/modules /vagrant/modules/puppet/manifests/bootstrap-master.pp --environment master --detailed-exitcodes --verbose --trace --debug


# yum install git -y
  # git clone ssh://git@prdcg4gerl01.oss.prd:7999/CODO/puppetconfig.git /tmp/puppetconfig
# ruby rubygems ruby-devel
# yum install 
# gem install librarian-puppet
# gem install r10k
