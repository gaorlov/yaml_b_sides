module YamlBSides
  module Propertiable
    extend ActiveSupport::Concern

    included do
      class_attribute :__properties
      self.__properties = {}

      class << self
        def properties( props = {} )
          self.__properties = __properties.dup
          merge_properties props
        end

        def property( prop, default = nil )
          merge_properties( { prop => default } )
        end

        protected

        def merge_properties( additional_properties = {} )
          self.__properties = __properties.merge( additional_properties )
        end
      end
    end
  end
end