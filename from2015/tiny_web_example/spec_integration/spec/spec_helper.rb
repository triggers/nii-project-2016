# -*- coding: utf-8 -*-

require 'rubygems'
require 'bundler'
Bundler.setup(:default)
Bundler.require(:test)

$LOAD_PATH << File.expand_path("./helpers", File.dirname(__FILE__))

require 'web_api_client'

require_relative 'helpers/logger'

RSpec.configure do |c|
  c.formatter = :documentation
  c.color     = true
end


