# -*- mode: ruby -*-
# vi: set ft=ruby :
# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "geo-concerns"
  config.vm.box_url = "file://./geo-concerns.box"

  config.ssh.insert_key = false

  config.vm.network :forwarded_port, guest: 3000, host: 3000 # GeoConcerns
  config.vm.network :forwarded_port, guest: 3001, host: 3001 # Geoblacklight
  config.vm.network :forwarded_port, guest: 8983, host: 8983 # Solr 5.4
  config.vm.network :forwarded_port, guest: 8984, host: 8984 # Fedora 4.5
  config.vm.network :forwarded_port, guest: 8181, host: 8181 # GeoServer
  config.vm.network :forwarded_port, guest: 9983, host: 9983 # Geoblacklight solr
  config.vm.network :forwarded_port, guest: 5672, host: 5672 # Rabbitmq
  config.vm.network :forwarded_port, guest: 15672, host: 15672 # Rabbitmq manager

  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
  end

  config.vm.provision "docker" do |d|
    d.run "gcsolr",
      image: "geoconcerns/solr",
      args: "--expose 8983 -p 8983:8983"
    d.run "fcrepo",
      image: "geoconcerns/fcrepo",
      args: "--expose 8984 -p 8984:8984"
    d.run "geoserver",
      image: "geoconcerns/geoserver",
      args: "-p 8181:8080"
    d.run "solr",
      image: "geoconcerns/geoblacklight-solr",
      args: "-p 9983:8983"
    d.run "rabbitmq",
      image: "rabbitmq:3.6.5-management",
      args: "-p 5672:5672 -p 15672:15672"
    d.run "geoblacklight",
      image: "geoconcerns/geoblacklight",
      args: "-p 3001:3000 --link solr --link rabbitmq --env RABBIT_SERVER=amqp://rabbitmq:5672"
  end
  
end
