# -*- mode: ruby -*-
# vi: set ft=ruby :
 
$nodes = [
  # Clean box
  {
    :name => :clean,
    :ip => '33.33.33.10',
  },
  # MongoDB box, with Chef 'mongo' role
  {
    :name => :mongo,
  },
  # Jenkins master box, with Chef 'jenkins' role
  {
    :name => :jenkins,
    :vbox_config => [
      { '--memory' => '1536' }
    ]

  }
]

load("BaseVagrantfile")