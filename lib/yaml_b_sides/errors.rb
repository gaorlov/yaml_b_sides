module YamlBSides
  module Errors
    class RecordNotFound < StandardError
    end

    class AssociationError < StandardError
    end

    class InvalidFieldError < StandardError
    end
  end
end