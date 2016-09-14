module YamlBSides
  class Base
    include ActiveModel::Model
    include Associatable
    include Cacheable
    include Propertiable
    include Indexable
    include Instanceable
    include Queriable

    class_attribute :logger
    class_attribute :root_path

    class << self

      def load!
        @data = YAML.load_file( data_file ).with_indifferent_access
        idify_data!
        logger.info "#{self} successfully loaded data"
        # let's preemptively index by id so that when we do a find_by id:, or a where id: it won't table scan
        index :id
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
