require 'test_helper'

class CacheableTest < Minitest::Test
  def test_cache_key_for_single_record_is_consistent
    key = Person.first.cache_key
    assert_equal key, Person.first.cache_key
    refute_equal key, Person.all[2].cache_key
  end

  def test_cache_key_for_table_is_consistent
    assert Person.cache_key
  end
end