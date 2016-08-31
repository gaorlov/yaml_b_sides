module YamlBSides
  module Instanceable
    extend ActiveSupport::Concern
    included do
      include ActiveModel::Model

      def initialize( attrs = {} )
        @attributes = self.class.__properties.merge( attrs ).with_indifferent_access
      end

      def method_missing( method, *args, &block )
        if @attributes.has_key? method
          method = @attributes[method]
        else
          super
        end
      end

      def to_param
        id
      end
    end
  end
end