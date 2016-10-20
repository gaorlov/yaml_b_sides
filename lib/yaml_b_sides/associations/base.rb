module YamlBSides
  module Associations
    class Base

      attr_accessor :name, :opts, :key

      def initialize( base_class, name, opts = {} )
        self.name = name
        self.opts = opts
        self.key  = idify base_class
      end

      def klass
        @klass ||= association_class name, opts
      end

      protected

      def association_class( name, opts = {} )
        a_class       = opts[:class]                   if opts.has_key? :class
        a_class_name  = opts[:class_name].constantize  if opts.has_key? :class_name

        a_class || a_class_name || derived_class_for( name )
      end

      def derived_class_for( name )
        name.to_s.singularize.classify.constantize
      end

      def idify( class_name )
        "#{class_name.to_s.demodulize.underscore}_id"
      end
    end
  end
end
