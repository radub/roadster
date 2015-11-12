class tools::nodejs {
  # package install list
  $packages = [
    "nodejs",
    "npm",
  ]

  package { $packages:
    ensure  => present,
    require => Exec["apt-get update"]
  }

  # fix node nodejs legacy issue
  file { '/usr/bin/node':
    ensure => 'link',
    target => '/usr/bin/nodejs',
  }

  exec { 'gem-install-sass':
    command => 'gem install sass',
    path    => '/usr/bin',
    user    => root
  }

  exec { 'install-gulp':
    command => 'npm install gulp -g',
    require => Package['npm']
  } ->
  exec { 'install-gulp-save-dev':
    command => 'npm install gulp --save-dev',
    require => Package['npm']
  }

  exec { 'install-gulp-extras':
    command => 'npm install gulp-ruby-sass gulp-autoprefixer gulp-minify-css gulp-rename',
    require => Exec['install-gulp']
  }
}