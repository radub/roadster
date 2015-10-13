class tools::solr {
  # @TODO
  # $ cd ~
  # $ wget http://apache.mirror1.spango.com/lucene/solr/5.3.0/solr-5.3.0.tgz
  # $ tar xzf solr-5.3.0.tgz solr-5.3.0/bin/install_solr_service.sh --strip-components=2
  # $ sudo bash ./install_solr_service.sh solr-5.3.0.tgz
  # $ sudo service solr restart
  #
  #
  # sudo apt-get install unzip

  service { "solr":
    ensure  => running,
    require => Package["solr"],
    notify  => Service["apache2"]
  }
}
