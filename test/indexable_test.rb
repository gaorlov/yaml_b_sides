require 'test_helper'

class IndexableTest < Minitest::Test
  def setup 
    Person.__indices = {}
    Person.index(:name)
    refute_empty Person.__indices
  end

  def teardown
    Person.__indices = {}
  end

  def test_can_add_index
    Person.index(:name)
    refute_empty Person.__indices
    assert_equal [:name], Person.__indices.keys
  end

  def test_index_silinces_find_by_warnings
    Person.logger = TestLogger.new :raise
    assert Person.find_by( name: "Josh Dreher" )
    Person.logger = YamlBSides::Base.logger
  end

  def test_complex_find_by_indexed_queries
    Person.index(:url_slug)
    Person.logger = TestLogger.new :raise
    assert Person.find_by( name: "Josh Dreher", url_slug: 'josh-dreher' )
    Person.logger = YamlBSides::Base.logger
  end
end