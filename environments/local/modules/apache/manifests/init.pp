class apache {

  # install apache
  package { "httpd":
    ensure => present,
    require => Exec["yum update"]
  }

  # ensures that mode_rewrite is loaded and modifies the default configuration file
  #
  # !!! it looks like mod_rewrite is enabled by default
  #
#  file { "/etc/httpd/mods-enabled/rewrite.load":
#    ensure => link,
#    target => "/etc/httpd/mods-available/rewrite.load",
#    require => Package["httpd"]
#  }

  # create directory
  file {"/etc/httpd/sites-enabled":
    ensure => directory,
    recurse => true,
    purge => true,
    force => true,
    before => File["/etc/httpd/sites-enabled/web.conf"],
    require => Package["httpd"],
  }

  # create apache config from main vagrant manifests
  file { "/etc/httpd/sites-available/web.conf":
    ensure => present,
    source => "/vagrant/vm-pp/manifests/assets/vhost.conf",
    require => Package["httpd"],
  }

  # symlink apache site to the site-enabled directory
  file { "/etc/httpd/sites-enabled/web.conf":
    ensure => link,
    target => "/etc/httpd/sites-available/web.conf",
    require => File["/etc/httpd/sites-available/web.conf"],
    notify => Service["httpd"],
  }

  # starts the apache2 service once the packages installed, and monitors changes to its configuration files and reloads if nesessary
  service { "httpd":
    ensure => running,
    require => Package["httpd"],
    subscribe => [
      File["/etc/httpd/mods-enabled/rewrite.load"],
      File["/etc/httpd/sites-available/web.conf"]
    ],
  }

  file {"/var/www/web":
    ensure => "link",
    target => "/vagrant/app",
    require => Package["httpd"],
    notify => Service["httpd"],
    replace => yes,
    force => true,
  }
}