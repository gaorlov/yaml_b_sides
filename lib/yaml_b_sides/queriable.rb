module YamlBSides
  module Queriable
    extend ActiveSupport::Concern

    included do
      class << self
        def find(id)
          new @data[id]
        end

        def find_by(params = {})
          if all_indexed?(params.keys)
            find_by_indexed(params)
          else
            find_by_scan(params)
          end
        end

        def all
          @data.values.map do |obj|
            new obj
          end
        end

        def first
          new @data.values.first
        end

        private

        def find_by_scan(params)
          result = @data.values.find do |datum|
            params.all? do |param, expcted_value|
              datum[param] == expcted_value
            end
          end
          result ? new(result) : nil
        end

        def find_by_indexed(params)
          sets = []
          params.each do |index, value|
            sets << find_in_index(index, value)
          end

          # find the intersection of all the sets
          sets.inject( sets.first ) do |result, subset|
            result & subset
         end
        end

        def all_indexed?(fields)
          fields.all? do |field|
            indexed = indexed? field
            unless indexed
              logger.warn "You are running a query on #{self}.#{field} which is not indexed. This will perform a table scan."
            end
            indexed
          end
        end
      end
    end
  end
end