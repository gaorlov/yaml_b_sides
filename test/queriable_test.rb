require 'test_helper'

class QueriableTest < Minitest::Test
  def test_can_find_by_id
    assert Person.find :josh
  end

  def test_can_find_by_any_field
    assert Person.find_by( url_slug: "josh-dreher" )
  end

  def test_can_find_by_many_fields
    assert Person.find_by( url_slug: "josh-dreher", name: "Josh Dreher" )
  end

  def test_unindexed_find_by_warns
    Person.logger = TestLogger.new :print
    assert_output "You are running a query on Person.url_slug which is not indexed. This will perform a table scan." do
      assert Person.find_by( url_slug: "josh-dreher" )
    end
    Person.logger = YamlBSides::Base.logger
  end

  def test_all
    ids = Person.all.map(&:id)
    assert_equal ["greg", "abby", "josh", "teal"], ids
  end
end