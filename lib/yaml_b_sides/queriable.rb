module YamlBSides
  module Queriable
    extend ActiveSupport::Concern

    included do
      class << self
        def find(id)
          record = data[id]
          raise Errors::RecordNotFound, "#{self}: Record not found: #{id}" unless record
          new record
        end

        def find_by(params = {})
          results = where params
          raise Errors::RecordNotFound, "#{self}: Could not find record that matches: #{params.inspect}" if results.empty?
          results.first
        end

        def all
          data.values.map do |obj|
            new obj
          end
        end

        def first
          new data.values.first
        end

        # TODO: move this into scopes
        def where(params)
          if all_indexed?(params.keys)
            results = find_by_indexed(params)
          else
            results = find_by_scan(params)
          end
          results.map do |result|
            new result
          end
        end

        private

        def find_by_scan(params)
          data.values.select do |datum|
            params.all? do |param, expected_value|
              val = Array(expected_value).include? datum[param]
            end
          end
        end

        def find_by_indexed(params)
          sets = []
          params.each do |index, values|
            sets << find_in_index(index, Array(values))
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