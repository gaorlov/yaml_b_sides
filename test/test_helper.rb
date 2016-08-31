$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
SimpleCov.start

require 'yaml_b_sides'

YamlBSides::Base.logger = Logger.new(STDOUT)
YamlBSides::Base.root_path = File.expand_path("./db/fixtures", File.dirname(__FILE__))

class Person < YamlBSides::Base
  property :not_in_yaml, :lol
end

require 'minitest/autorun'
