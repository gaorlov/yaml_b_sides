module YamlBSides
  module Associations
    class HasOne < Base
      def action
        :find_by
      end

      def query( instance )
        { key => instance.id }
      end
    end
  end
end
