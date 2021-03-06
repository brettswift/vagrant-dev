#!/bin/bash
echo "## running vagrant bootstrap ##"


############################### 
# Functions 

# return 1 if global command line program installed, else 0
# example
# echo "node: $(program_is_installed node)"
function program_is_installed {
  local return_=0
  if which $1 &> /dev/null; then
    local return_=1 #set to 1 when found
  fi
  echo "$return_"
}

#idempotent gem install 
# example:  install_gem gem_name
function install_gem() {
	found=`gem list $1 | grep -i $1`

  if [ "$found" != "" ]; then
    echo "$1 already installed"
 		parts=( $found )
    echo "Found ${parts[0]} ${parts[1]}"
  else
    echo "---------------------------"
	  echo "Installing $@ " #(all commands to accept versioning and other options)
	  sudo gem install $@ -y --no-rdoc --no-ri
	  echo "---------------------------"
  fi
}
 
# usage:  $1 = module
function install_puppet_module_if_required {
 output=`su root -c 'puppet module list'`
 echo $output
 if [[ "$output" == *"$1"* ]]; then
   echo "module $1 already installed"
 else
   echo `su root -c "puppet modulesle install $1"`
   echo "module $1 finished installing"
   echo "** ignore the above message about command not found**"
 fi
}
##############################

install_gem librarian-puppet -v 0.9.11

cd /vagrant
librarian-puppet install

# Use our Hiera configuration
# sudo rm -rf /etc/puppetlabs/puppet/hiera.yaml /etc/hiera.yaml
# ln -s /vagrant/modules/puppet/files/hiera.yaml /etc/puppetlabs/puppet/hiera.yaml
# ln -s /vagrant/modules/puppet/files/hiera.yaml /etc/hiera.yaml

# echo "$(install_puppet_module_if_required puppetlabs-stdlib)"
# echo "$(install_puppet_module_if_required erwbgy-limits)"
# echo "$(install_puppet_module_if_required thias-sysctl)"
# echo "$(install_puppet_module_if_required acme/ohmyzsh)"
