class tools::memcached {
  # package install list
  $packages = [
    "php5-memcached",
    "memcached",
  ]

  package { $packages:
    ensure => present,
    require => Exec["apt-get update"]
  }

  service { "memcached":
    ensure  => running,
    require => Package["memcached"],
    notify  => Service["apache2"]
  }
}