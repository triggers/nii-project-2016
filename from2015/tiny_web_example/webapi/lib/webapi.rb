# -*- coding: utf-8 -*-

WEBAPI_ROOT = ENV['WEBAPI_ROOT'] || File.expand_path('../../', __FILE__)
require 'webapi/version'
require 'webapi/initializer'

module Webapi
  include Webapi::Initializer
  initializer_hooks {
    initializers_root = File.expand_path('config/initializers', ::WEBAPI_ROOT)

    @files.each { |file|
      if File.directory?(initializers_root)
        Dir.glob("#{initializers_root}/#{file}.rb") { |f|
          ::Kernel.load(f)
        }
      end
    }
  }

  require 'webapi/configurations'
  module Configurations
    autoload :Webapi, 'webapi/configurations/webapi'
  end

  require 'webapi/models/errors'
  module Models
    autoload :BaseNew, 'webapi/models/base'
    autoload :Comment, 'webapi/models/comment'
  end

  module Endpoints
    autoload :Helpers, 'webapi/endpoints/helpers'
    autoload :Errors, 'webapi/endpoints/errors'
    autoload :ResponseGenerator, 'webapi/endpoints/response_generator'
    module V001
      autoload :Webapi, 'webapi/endpoints/0.0.1/webapi'
      autoload :Comment, 'webapi/endpoints/0.0.1/comments'
      module Responses
      end
    end
  end
end
