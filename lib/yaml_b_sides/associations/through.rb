module YamlBSides
  module Associations
    module Through
      extend ActiveSupport::Concern

      included do

        def query( instance )
          unless opts.has_key? :through
            { key => instance.id }
          else
            { id: target_ids( instance ) }
          end
        end

        protected

        def through
          opts[:through]
        end

        def target_ids( instance )
          intermadiates = Array(instance.send( through ) )
          
          intermadiates.map do | intermediate | 
            intermediate.send( through_key )
          end
        end
        
        def through_key
          idify klass
        end
      end
    end
  end
end