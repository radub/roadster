class php {

  # package install list
  $packages = [
    "php5",
    "php-pear",
    "php5-dev",
    "php5-common",
    "php5-cli",
    "php5-mysql",
    "php-apc",
    "php5-xdebug",
    "php5-curl",
    "php5-gd",
    "php5-mcrypt",
    "php5-ldap",
    "libapache2-mod-php5"
  ]

  package { $packages:
    ensure => present,
    require => Exec["apt-get update"]
  }

  exec { 'enable-php5-mcrypt':
    command => 'php5enmod mcrypt',
    require => [ Package['php5-mcrypt'], Package['apache2'] ],
    notify  => Service["apache2"]
  }

  exec { 'enable-php5-gd':
    command => 'php5enmod gd',
    require => [ Package['php5-gd'], Package['apache2'] ],
    notify  => Service["apache2"]
  }

  exec { 'enable-php5-ldap':
    command => 'php5enmod ldap',
    require => [ Package['php5-ldap'], Package['apache2'] ],
    notify  => Service["apache2"]
  }
  
  file { "/etc/php5/mods-available/xdebug.ini":
    ensure => present,
    source => "/vagrant/environments/local/modules/php/assets/xdebug.conf",
    require => [ Package["apache2"], Package["php5-xdebug"] ]
  }

}
