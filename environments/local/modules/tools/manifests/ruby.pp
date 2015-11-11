class tools::ruby {
  # package install list
  $packages = [
    "rubygems-integration",
    "ruby-full",
    "build-essential",
    "zlib1g-dev",
    "libssl-dev",
    "libreadline-dev",
    "libyaml-dev",
    "libsqlite3-dev",
    "sqlite3",
    "libxml2-dev",
    "libxslt1-dev",
    "libcurl4-openssl-dev",
    "python-software-properties",
    "libffi-dev",
    "libgdbm-dev",
    "libncurses5-dev",
    "automake",
    "libtool",
    "bison"
  ]

  package { $packages:
    ensure  => present,
    require => Exec["apt-get update"]
  }

  # implement https://gorails.com/setup/ubuntu/14.04 rvm method

  exec { 'update-rvm-key':
    command => '/usr/bin/gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3'
  } ->
  exec { 'curl-rvm':
    command => '/usr/bin/curl -L https://get.rvm.io | bash -s stable'
  } ->
  exec { 'install-ruby-2.2.3':
    command => '/usr/local/rvm/bin/rvm install 2.2.3'
  } ->
  exec { 'use-ruby-2.2.3':
    command => '/usr/local/rvm/bin/rvm use 2.2.3 --default'
  }

}