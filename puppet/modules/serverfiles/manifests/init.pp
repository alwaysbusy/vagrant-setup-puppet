class serverfiles {
  
  file { 'info.php' :
    require => Class['apache'],
    ensure => file,
    path => '/var/www/html/info.php',
    source => 'puppet:///modules/serverfiles/info.php',
  }
  
}
