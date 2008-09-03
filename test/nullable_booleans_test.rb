require 'test/unit'

require 'rubygems'
require 'activerecord'
require 'nullable_booleans'

class NullableBooleansTest < Test::Unit::TestCase
  class TestObject < ActiveRecord::Base
    establish_connection(:adapter => 'sqlite3', :database => ':memory:')
    connection.create_table(table_name) do |t|
      t.boolean :yes_no_maybe
    end
  end

  def teardown
    TestObject.destroy_all
  end

  def test_attribute_is_nullable
    assert_nil TestObject.create!(:yes_no_maybe => nil).reload.yes_no_maybe
    assert_nil TestObject.create!(:yes_no_maybe => '').reload.yes_no_maybe
  end

  def test_attribute_is_settable
    assert_equal true, TestObject.create!(:yes_no_maybe => '1').reload.yes_no_maybe
    assert_equal false, TestObject.create!(:yes_no_maybe => '0').reload.yes_no_maybe
  end
end
