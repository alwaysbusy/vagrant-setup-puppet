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
  include lamp
}
