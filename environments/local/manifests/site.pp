# /manifests/site.pp
Exec {
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}
include bootstrap
include apache
include php
include mysql
include tools
include tools::jenkins
