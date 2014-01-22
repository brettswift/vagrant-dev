#!/bin/bash
echo "## running vagrant bootstrap ##" }


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

# usage:  $1 = module
function install_puppet_module_if_required {
 output=`su root -c 'puppet module list'`
 echo $output
 if [[ "$output" == *"$1"* ]]; then
   echo "module $1 already installed"
 else
   echo `su root -c "puppet module install $1"`
   echo "module $1 finished installing"
   echo "** ignore the above message about command not found**"
 fi
}
##############################



# Use our Hiera configuration
sudo rm -rf /etc/puppetlabs/puppet/hiera.yaml /etc/hiera.yaml
ln -s /vagrant/modules/puppet/files/hiera.yaml /etc/puppetlabs/puppet/hiera.yaml
ln -s /vagrant/modules/puppet/files/hiera.yaml /etc/hiera.yaml

echo "$(install_puppet_module_if_required puppetlabs-stdlib)"
echo "$(install_puppet_module_if_required erwbgy-limits)"
echo "$(install_puppet_module_if_required thias-sysctl)"
echo "$(install_puppet_module_if_required puppetlabs-ntp)"
echo "$(install_puppet_module_if_required smarchive-virtualbox"
#puppet module install puppetlabs-pe_gem

# Create alias for easy Puppet testing
#TODO: make this idempotent.  multiple vagrant provisions will result in a hilarious .bashrc file
echo "alias pp='puppet apply /etc/puppetlabs/puppet/environments/master/manifests/site.pp --environment master --modulepath=/etc/puppetlabs/puppet/modules/:/etc/puppetlabs/puppet/environments/master/modules/'" >> /root/.bashrc
