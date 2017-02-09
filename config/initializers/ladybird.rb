require 'active_support/core_ext/hash/indifferent_access'
require 'tiny_tds'

config = YAML.load(ERB.new(File.read("#{GeoConcerns.root}/config/ladybird.yml")).result)

lbuser = config.fetch("username").strip
lbpw = config.fetch("password").strip
lbhost = config.fetch("host").strip
lbdb = config.fetch("database").strip

::SQLServer = TinyTds::Client.new(:username => lbuser,:password => lbpw,:host => lbhost,:database => lbdb)
