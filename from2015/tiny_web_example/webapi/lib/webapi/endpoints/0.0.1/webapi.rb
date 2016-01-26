# -*- coding: utf-8 -*-

require 'sinatra/base'
require 'sinatra/web_api_setup'

module Webapi
  module Endpoints
    module V001
      class Webapi < Sinatra::Base
        register Sinatra::WebAPISetup
        include ::Webapi::Endpoints
        include ::Webapi::Endpoints::Helpers

        E = ::Webapi::Endpoints::Errors
        M = ::Webapi::Models
        R = ::Webapi::Endpoints::V001::Responses

        def collection_respond_with(ds, &blk)
          respond_with([{
                          :total => ds.count,
                          :results => blk.call(ds)
                        }])
        end

        load_namespace('comments')

        # default output format.
        respond_to :json, :yml

        def desc_api
          {:description => 'comments', :uri => request.url + '/comments'}
        end

        get '/' do
          {:api => desc_api}.to_json
        end

        post '/' do
          405
        end

        delete '/' do
          405
        end

        put '/' do
          405
        end

        error 400 do
          response.header['Allow'] = 'GET, POST'
          {:code => 400, :message => "Bad Request"}.to_json
        end

        error 405 do
          response.header['Allow'] = 'GET, POST'
          {:code => 405, :message => "Method Not Allowed"}.to_json
        end
      end
    end
  end
end
