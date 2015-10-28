class tools::nodejs {
  # package install list
  $packages = [
    "nodejs",
    "npm",
  ]

  package { $packages:
    ensure => present,
    require => Exec["apt-get update"]
  }

}