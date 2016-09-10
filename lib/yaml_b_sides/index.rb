module YamlBSides
  class Index
    def initialize(field, data)
      @indexed_data = {}
      data.each do |id, datum|
        key = datum[field]

        @indexed_data[key] = Array(@indexed_data[key]) + [id]
      end
    end

    def find(value)
      @indexed_data[value]
    end
  end
end