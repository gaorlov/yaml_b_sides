module YamlBSides
  module Associations
    class BelongsTo < Base
      def action
        :find
      end

      def key
        "#{name}_id"
      end

      def query( instance )
        instance.send key
      end

      def klass( instance )
        if polymorphic?
          class_name = instance.send "#{name}_class"
          class_name.constantize
        else
          super
        end
      end

      protected

      def additional_options
        [ :polymorphic ]
      end

      def polymorphic?
        opts[:polymorphic]
      end
    end
  end
end
