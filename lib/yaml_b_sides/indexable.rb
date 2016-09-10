module YamlBSides
  module Indexable
    extend ActiveSupport::Concern

    included do
      class_attribute :__indices
      self.__indices = {}

      class << self
        def index(field)
          self.__indices = __indices.merge( { field => Index.new(field, @data) } )
        end

        def find_in_index(field, value)
          keys = Array(index_for(field).find(value))
          
          keys.map do |id|
            @data[id]
          end
        end

        def indexed?(field)
          __indices[field].present?
        end

        protected 

        def index_for(field)
          __indices[field]
        end

      end
    end
  end
end