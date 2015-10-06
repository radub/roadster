class tools::jenkins {
  # package install list
  $packages = [
    "jenkins"
  ]

  exec { 'jenkins-update-source-list':
    command => "sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'"
  } ->

  exec { 'jenkins-add-key':
    command => 'wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -'
  } ->

  exec { 'jenkins-update-source':
    command => '/usr/bin/apt-get update -y'
  }

  package { $packages:
    ensure => present,
    require => Exec["apt-get update"]
  }

  service { "jenkins":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    require    => Package["jenkins"]
  }
}