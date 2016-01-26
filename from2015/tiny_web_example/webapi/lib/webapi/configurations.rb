# -*- coding: utf-8 -*-

module Webapi
  module Configurations
    # Set the dynamic config name method. For example:
    # loading webapi.conf will create Webapi::Configurations.webapi method.
    def self.store_conf(name, conf)
      @conf ||= Hash.new { |hash, key| raise "'#{key}' was not loaded." }
      @conf[name.to_sym] = conf
    end

    def self.load(conf_class, files = nil)
      path = if files
               path = files.find { |f| File.exists?(f) }
               abort("ERROR: Failed to load #{files.inspect}.") if path.nil?

               path
             end

      begin
        conf_name = conf_class.name.split("::").last.downcase
        store_conf(conf_name, conf_class.load(path))
      rescue NoMethodError => e
        abort("Syntax Error: #{path}\n #{e.backtrace.first} #{e.message}")
      end
    end

    def self.loaded?(name = nil)
      if name.nil?
        ! @conf.nil?
      else
        @conf.has_key?(name.to_sym)
      end
    end

    # This allows us to access the configurations as if they're methods of
    # Webapi::Configurations.
    # For example: Webapi::Configurations.webapi will access webapi.conf
    def self.method_missing(method_name, *args)
      @conf[method_name]
    end
  end
end
