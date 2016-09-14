module YamlBSides
  module Associations
    class HasMany < Base
      def action
        :where
      end

      def query( instance )
        { key => instance.id }
      end
    end
  end
end
