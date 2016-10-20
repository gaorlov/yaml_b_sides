module YamlBSides
  class Index
    def initialize(field, data)
      @indexed_data = {}
      data.each do |id, datum|
        key = datum[field]

        # storing key => array of matching ids
        @indexed_data[key] = Array(@indexed_data[key]) + [id]
      end
    end

    # returns ids 
    def find(values)
      # find all the arrays of ids for the values, 
      #   get rid of nils (value not present), 
      #   and compact for a single array result
      values.map do |value|
        @indexed_data[value]
      end.compact.flatten
    end
  end
end