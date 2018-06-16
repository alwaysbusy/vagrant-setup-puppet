class lamp {
  exec { 'apt-update' :
    command => '/usr/bin/apt-get update',
  }

  package { 'mysql-server' :
    require => Exec['apt-update'],
    ensure => installed,
  }

  service { 'mysql' :
    ensure => running,
  }

  package { 'php7.0' :
    require => Exec['apt-update'],
    ensure => installed,
  }

  file { '/var/www/html/info.php' :
    ensure => file,
    content => '<?php phpinfo(); ?>',
  }
}
