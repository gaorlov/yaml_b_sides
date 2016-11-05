module YamlBSides
  module Associatable
    extend ActiveSupport::Concern

    included do
      class_attribute :__associations
      self.__associations = {}

      attr_accessor :_cached_associations

      class << self

        def belongs_to( name, opts = {} )
          association = Associations::BelongsTo.new( self, name, opts )
          process association
          index association.key
        end

        def has_one( name, opts = {} )
          process Associations::HasOne.new( self, name, opts )
        end

        def has_many( name, opts = {} )
          process Associations::HasMany.new( self, name, opts )
        end
        
        protected

        def process( association )
          associate association
          methodize association
        end

        def associate( association )
          self.__associations = __associations.merge association.name => association
        end

        def methodize( association )
          define_method association.name do
            begin
              self._cached_associations ||= {}

              unless self._cached_associations.has_key? association.name
                result = association.klass( self ).send( association.action, association.query( self ) )
                
                self._cached_associations[association.name] = result
              end
              self._cached_associations[association.name]
            rescue YamlBSides::Errors::RecordNotFound => e
              nil
            end
          end
        end
      end
    end
  end
end