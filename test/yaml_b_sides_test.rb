require 'test_helper'

class YamlBSidesTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::YamlBSides::VERSION
  end

  def test_can_init_object
    a = Person.new
    assert a
    assert_equal :lol, a.not_in_yaml
  end

  def test_method_missing_picks_up_properties
    a = Person.new( {a: :b} )
    assert_equal :b, a.a
  end

end
