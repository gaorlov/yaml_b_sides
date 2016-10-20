module YamlBSides
  module Associations
    class HasMany < Base
      include Through

      def action
        :where
      end
    end
  end
end
