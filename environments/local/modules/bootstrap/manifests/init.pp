class bootstrap {

  # silence puppet and vagrant annoyance about the puppet group
  group { 'puppet':
    ensure => 'present'
  }

  # ensure local apt cache index is up to date before beginning
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update -y'
  }

  # fix locale
  exec { 'locale-gen':
    command => 'sudo locale-gen "en_US.UTF-8"'
  }

}
