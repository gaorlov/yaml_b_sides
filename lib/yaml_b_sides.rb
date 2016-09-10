require "yaml_b_sides/version"
require 'active_model'
require 'active_model/model'
require 'active_support'
require 'active_support/concern'
require 'active_support/core_ext/class/attribute'
require 'active_support/core_ext/hash'
require 'yaml'

module YamlBSides
  autoload :Base,           'yaml_b_sides/base'
  autoload :Cacheable,      'yaml_b_sides/cacheable'
  autoload :Instanceable,   'yaml_b_sides/instanceable'
  autoload :Index,          'yaml_b_sides/index'
  autoload :Indexable,      'yaml_b_sides/indexable'
  autoload :Propertiable,   'yaml_b_sides/propertiable'
  autoload :Queriable,      'yaml_b_sides/queriable'
end
