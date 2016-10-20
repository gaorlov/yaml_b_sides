require 'test_helper'

class AssociatableTest < Minitest::Test
  def test_has_one_adds_association
    Person.belongs_to :fake
    assert_equal [:person_shoes, :favorite_shoes, :fake], Person.__associations.keys
    assert_equal YamlBSides::Associations::BelongsTo, Person.__associations.values.last.class
  end

  def test_has_one_adds_association
    Person.has_one :fake
    assert_equal [:person_shoes, :favorite_shoes, :fake], Person.__associations.keys
    assert_equal YamlBSides::Associations::HasOne, Person.__associations.values.last.class
  end

  def test_has_many_adds_association
    Person.has_many :fake
    assert_equal [:person_shoes, :favorite_shoes, :fake], Person.__associations.keys
    assert_equal YamlBSides::Associations::HasMany, Person.__associations.values.last.class
  end

  def test_belongs_to_correctly_queries
    assert_equal "La Sportiva", Shoe.find( :solution ).manufacturer.name
  end

  def test_has_one_correctly_queries
    assert_equal "http://placekitten.com/300/300", Manufacturer.find( :la_sportiva ).logo.image_url
  end

  def test_has_many_correctly_queries
    assert_equal ["Solution", "Speedster"], Manufacturer.find( :la_sportiva ).shoes.map(&:name)
  end

  def test_through_correctly_queries
    # assert_equal ["European", "American"], Manufacturer.find( :five_ten ).sizes.map(&:name)
    assert_equal "Solution", Person.find( :abby ).favorite_shoes.name
  end
end