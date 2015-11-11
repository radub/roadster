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

  exec { 'install-gulp':
    command => 'npm install gulp -g',
    require => Package['npm']
  }

  exec { 'install-gulp-extras':
    command => 'npm install gulp-ruby-sass gulp-autoprefixer gulp-minify-css gulp-rename',
    require => Exec['install-gulp']
  }
}