module YamlBSides
  module Queriable
    extend ActiveSupport::Concern

    included do
      class << self
        def find(id)
          new @data[id]
        end

        def find_by(params = {})
          result = @data.values.find do |datum|
            params.all? do |param, expcted_value|
              datum[param] == expcted_value
            end
          end
          result ? new(result) : nil
        end

        def all
          @data.values.map do |obj|
            new obj
          end
        end
      end
    end
  end
end