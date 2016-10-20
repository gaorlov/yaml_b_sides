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
  has_many :person_shoes
  has_one :favorite_shoes, through: :person_shoes, class_name: "Shoe"
end

class PersonShoe < YamlBSides::Base
  belongs_to :person
  belongs_to :shoe
end

class Fake < YamlBSides::Base
end

class Logo < YamlBSides::Base
  belongs_to :manufacturer
end

class ManufacturerSize < YamlBSides::Base
  belongs_to :manufacturers
  belongs_to :sizes
end

class Manufacturer < YamlBSides::Base
  has_many :shoes
  has_one  :logo
  has_many :manufacturer_sizes
  has_many :sizes, through: :manufacturer_sizes
end

class Shoe < YamlBSides::Base
  belongs_to :manufacturer
end

class Size < YamlBSides::Base
end

require 'minitest/autorun'
