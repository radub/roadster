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

  # @TODO enable php5-mcrypt: sudo php5enmod mcrypt

  package { $packages:
    ensure => present,
    require => Exec["apt-get update"]
  }

}
