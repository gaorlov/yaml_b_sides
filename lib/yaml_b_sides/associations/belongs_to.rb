module YamlBSides
  module Associations
    class BelongsTo < Base
      def action
        :find
      end

      def query( instance )
        instance.send "#{name}_id"
      end
    end
  end
end
