module YamlBSides
  class Base
    include ActiveModel::Model
    include Cacheale
    include Propertiable
    include Instanceable
    include Queriable

    class_attribute :logger
    class_attribute :root_path

    class << self

      def load!
        puts data_file
        @data = YAML.load_file( data_file ).with_indifferent_access
        idify_data!
        puts "#{self} successfully loaded data"
      rescue => e
        logger.error "#{self} failed to load data: #{e}"
      end

      def inherited(subclass)
        subclass.load!
      end

      protected

      def data_file
        [root_path, "#{self.name.pluralize.downcase}.yml"].compact.join("/")
      end

      def idify_data!
        @data.each do |k, v|
          v[:id] = k
        end
      end
    end
  end
end
