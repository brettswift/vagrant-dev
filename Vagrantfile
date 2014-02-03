# -*- mode: ruby -*-
# vi: set ft=ruby :
 
$nodes = [
  # Clean box
  {
    :name         => :clean,
    :forward_x11  => true,
    :synced_folders => [['../sandbox','/home/vagrant/sandbox']],
    :synced_folders_create => true,
  },
  # nodejs
  {
    :name => :nodejs,
  },
]

load("BaseVagrantfile")