Vagrant Dev
===========
A placeholder for puppet development environments and utility environments, using hiera to plug and play features ad-hoc. 

Goals
-----
1. Function with either Puppet Open Source or Puppet Enterprise

Bootstrapping
-------------
If you use a base box that doesn't have puppet installed, this will install it for you. 

You have an option of using Puppet Open Source or Puppet Enterprise.   Just change the variable:  `use_puppet_enterprise` in the vagrant file. 

*Both bootstrap scripts will do nothing if puppet is found in the path.*

Boxes
------
- TBD!