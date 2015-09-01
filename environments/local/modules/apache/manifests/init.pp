class apache {

  # install apache
  package { "apache2":
    ensure => present,
    require => Exec["apt-get update"]
  }

  # make sure sites-available directory exists
  file {"/etc/apache2/sites-available":
    ensure => directory,
    recurse => true,
    purge => true,
    force => true,
    before => File["/etc/apache2/sites-available/web.conf"],
    require => Package["apache2"],
  }

  # make sure sites-enabled directory exists
  file {"/etc/apache2/sites-enabled":
    ensure => directory,
    recurse => true,
    purge => true,
    force => true,
    before => File["/etc/apache2/sites-enabled/web.conf"],
    require => Package["apache2"],
  }

  # create vhost from assets
  file { "/etc/apache2/sites-available/web.conf":
    ensure => present,
    source => "/vagrant/environments/local/modules/apache/assets/vhost.conf",
    require => Package["apache2"],
  }

  # create vhost-ssl from assets
  file { "/etc/apache2/sites-available/web-ssl.conf":
    ensure => present,
    source => "/vagrant/environments/local/modules/apache/assets/vhost-ssl.conf",
    require => Package["apache2"],
  }

  # enable site
  file { "/etc/apache2/sites-enabled/web.conf":
    ensure => link,
    target => "/etc/apache2/sites-available/web.conf",
    require => File["/etc/apache2/sites-available/web.conf"],
    notify => Service["apache2"],
  }

  # enable site-ssl
  file { "/etc/apache2/sites-enabled/web-ssl.conf":
    ensure => link,
    target => "/etc/apache2/sites-available/web-ssl.conf",
    require => File["/etc/apache2/sites-available/web-ssl.conf"],
    notify => Service["apache2"],
  }

  # starts the apache2 service once the packages installed, and monitors changes to its configuration files and reloads if necessary
  service { "apache2":
    ensure => running,
    require => Package["apache2"],
    subscribe => [
      File["/etc/apache2/sites-enabled/web.conf"],
      File["/etc/apache2/sites-enabled/web-ssl.conf"]
    ],
  }

  # enable apache mod_rewrite
  exec { "a2enmod-rewrite":
    creates => "/etc/apache2/mods-enabled/rewrite.load",
    command => "/usr/sbin/a2enmod rewrite",
    require => Package["apache2"],
    notify  => Service["apache2"],
  }

  # symlink application code to web root directory
  file {"/var/www/web":
    ensure => "link",
    target => "/opt/web",
    require => Package["apache2"],
    notify => Service["apache2"],
    replace => yes,
    force => true,
  }
}