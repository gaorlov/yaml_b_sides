module YamlBSides
  module Associations
    autoload :Base,       'yaml_b_sides/associations/base'
    autoload :BelongsTo,  'yaml_b_sides/associations/belongs_to'
    autoload :HasMany,    'yaml_b_sides/associations/has_many'
    autoload :HasOne,     'yaml_b_sides/associations/has_one'
  end
end