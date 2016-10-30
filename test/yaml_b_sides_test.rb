require 'test_helper'

class YamlBSidesTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::YamlBSides::VERSION
  end

  def test_can_init_object
    a = Person.send :new
    assert a
    assert_equal :lol, a.not_in_yaml
  end

  def test_method_missing_picks_up_properties
    a = Person.send( :new, {a: :b} )
    assert_equal :b, a.a
  end

  def test_method_missing_raises_invalid_method_on_missing_method
    a = Person.send( :new, {id: :lol} )
    assert_raises YamlBSides::Errors::InvalidFieldError do
      a.not_a_thing
    end
  end

  def test_properties_can_be_assigned_in_bulk
    Fake.properties a: :b, c: nil
    assert_equal( { a: :b, c: nil }, Fake.__properties )
  end

  def test_class_will_error_without_a_yaml_file
    Fake.logger = TestLogger.new :puts
    assert_output /Fake failed to load data: No such file or directory @ rb_sysopen - .*yaml_b_sides\/test\/db\/fixtures\/fakes.yml/ do
      Fake.load!
    end
  end
end
