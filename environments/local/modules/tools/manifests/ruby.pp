class tools::ruby {
  # package install list
  $packages = [
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
  ]

  package { $packages:
    ensure => present,
    require => Exec["apt-get update"]
  }

  # implement https://gorails.com/setup/ubuntu/14.04 rbenv method

}