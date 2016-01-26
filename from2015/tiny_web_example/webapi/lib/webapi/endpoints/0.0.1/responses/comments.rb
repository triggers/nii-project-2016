# -*- coding: utf-8 -*-

module Webapi::Endpoints::V001::Responses
  class Comment < Webapi::Endpoints::ResponseGenerator
    def initialize(comment)
      raise ArgumentError if !comment.is_a?(Webapi::Models::Comment)
      @comment = comment
    end

    def generate
      @comment.instance_exec {
        {
          :id => id,
          :display_name => display_name,
          :comment => comment,
          :created_at => created_at,
          :updated_at => updated_at,
        }
      }
    end
  end

  class CommentCollection < Webapi::Endpoints::ResponseGenerator
    def initialize(ds)
      raise ArgumentError if !ds.is_a?(Sequel::Dataset)
      @ds = ds
    end

    def generate
      @ds.all.map { |i|
        Comment.new(i).generate
      }
    end
  end
end
