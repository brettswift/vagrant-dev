# -*- mode: ruby -*-
# vi: set ft=ruby :
 
$nodes = [
  {# Clean box
    :name         => :clean,
    :forward_x11  => true,
    :synced_folders => [['../sandbox','/home/vagrant/sandbox']],
    :synced_folders_create => true,
  },
  {# training box (with desktop)
    :name         => :training,
    :forward_x11  => true,
    :synced_folders => [['../sandbox','/home/developer/sandbox']],
    :synced_folders_create => true,
    :displayGui   => true,
    :ram=>"1024",
  },
  # nodejs
  {
    :name => :nodejs,
  },
]

load("BaseVagrantfile")