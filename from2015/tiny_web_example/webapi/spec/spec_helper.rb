# -*- coding: utf-8 -*-

require 'rubygems'
require 'bundler'

Bundler.setup(:default)
Bundler.require(:test)

$LOAD_PATH << File.expand_path("../lib", File.dirname(__FILE__))
require 'webapi'

RSpec.configure do |c|
  c.formatter = :documentation
  c.color     = true
end

Webapi::Configurations.load Webapi::Configurations::Webapi,
  [File.expand_path('../webapi.conf', __FILE__)]
Webapi.run_initializers('sequel')
