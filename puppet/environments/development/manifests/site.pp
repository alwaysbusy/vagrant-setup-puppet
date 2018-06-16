node default {
  class { 'apache' :
    default_vhost => false,
    default_mods => false,
    mpm_module => 'prefork',
  }
  include apache::mod::php
  apache::vhost { 'localhost' :
    port => '80',
    docroot => '/var/www/html',
  }

  class { 'mysql::server' :
    root_password => 'password',
  }

  include php

  include serverfiles
}
