module YamlBSides
  module Associations
    class HasOne < Base
      include Hasable 

      def action
        :find_by
      end
    end
  end
end
