# -*- coding: utf-8 -*-

module Webapi
  module Models
    class Comment < Sequel::Model
      plugin :validation_helpers
      plugin :timestamps, :update_on_create => true

      private
      def before_validation
        if self.display_name.size > 100
          errors.add(:display_name, "size must be 10 or less.")
        end

        super
      end
    end
  end
end
