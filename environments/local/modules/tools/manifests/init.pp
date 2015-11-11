class tools {

  # package install list
  $packages = [
    "curl",
    "vim",
    "htop",
    "git-core",
    "bash-completion",
  ]

  # install packages
  package { $packages:
    ensure  => present,
    require => Exec["apt-get update"]
  }

  exec { 'composer-install':
    command => 'curl -sS https://getcomposer.org/installer | php && sudo mv composer.phar /usr/local/bin/composer',
    path    => '/usr/bin:/usr/sbin',
    require => Package['curl']
  } ->
  file { '/etc/profile.d/add-composer-to-path.sh':
    ensure  => present,
    content => 'export PATH="$HOME/.composer/vendor/bin:$PATH"'
  }

  exec { 'drush-install':
    command     => '/usr/local/bin/composer global require drush/drush:dev-master',
    environment => ["COMPOSER_HOME=/home/vagrant/.composer"],
    require     => Exec['composer-install']
  }
}