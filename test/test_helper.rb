$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
SimpleCov.start

require 'yaml_b_sides'

YamlBSides::Base.logger = Logger.new('/dev/null')
YamlBSides::Base.root_path = File.expand_path("./db/fixtures", File.dirname(__FILE__))

class TestLogger
  def initialize(action)
    @action = action
  end
  [:fatal, :error, :warn, :info, :debug].each do |severity|
    define_method severity do |message, &block|
      send @action, message
    end
  end
end

class Person < YamlBSides::Base
  property :not_in_yaml, :lol
end

class Fake < YamlBSides::Base
end

class Logo < YamlBSides::Base
  belongs_to :manufacturer
end

class Manufacturer < YamlBSides::Base
  has_many :shoes
  has_one  :logo
end

class Shoe < YamlBSides::Base
  belongs_to :manufacturer
end

require 'minitest/autorun'
