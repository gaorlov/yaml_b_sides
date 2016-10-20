module YamlBSides
  module Associations
    class HasOne < Base
      include Through 

      def action
        :find_by
      end
    end
  end
end
