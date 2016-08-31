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
  autoload :Instanceable,   'yaml_b_sides/instanceable'
  autoload :Propertiable,   'yaml_b_sides/propertiable'
  autoload :Queriable,      'yaml_b_sides/queriable'
end
