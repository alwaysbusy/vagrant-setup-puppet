class php {
  exec { 'apt-update' :
    command => '/usr/bin/apt-get update',
  }

  package { 'php7.0' :
    require => Exec['apt-update'],
    ensure => installed,
  }
}
