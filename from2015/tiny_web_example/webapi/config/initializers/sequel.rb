# -*- coding: utf-8 -*-

require 'sequel'

cfg = if Webapi::Configurations.loaded?(:webapi)
        Webapi::Configurations.webapi
      else
        abort "No config file with database information loaded."
      end

db = Sequel.connect(cfg.database_uri)

# Force to set "READ COMMITTED" isolation level.
# This mode is supported by both InnoDB and MySQL Cluster backends.
db.transaction_isolation_level = :committed

if ENV['DEBUG_SQL']
  requrie 'logger'
  db.loggers << Logger.new(STDERR)
end

Sequel::MySQL.default_charset = 'utf8'
Sequel::MySQL.default_collate = 'utf8_general_ci'
Sequel::MySQL.default_engine = ENV['MYSQL_DB_ENGINE'] || 'InnoDB'

# Set timezone to UTC
Sequel.default_timezone = :utc
