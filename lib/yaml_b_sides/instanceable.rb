module YamlBSides
  module Instanceable
    extend ActiveSupport::Concern
    included do
      include ActiveModel::Model

      def method_missing( method, *args, &block )
        if @attributes.has_key? method
          method = @attributes[method]
        else
          raise YamlBSides::Errors::InvalidFieldError, "#{self.class}:#{@attributes[:id]}: Invalid field: '#{method}'"
        end
      end

      protected

      # public init really doesn't make sense for a read-only interface
      def initialize( attrs = {} )
        @attributes = self.class.__properties.merge( attrs ).with_indifferent_access
      end
    end
  end
end