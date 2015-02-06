require 'sqlite3'
DATABASE = SQLite3::Database.new('test_warehouse_database.db')
require 'minitest/autorun'
require_relative 'db_setup'
require_relative "Product"
require_relative "Location"
require_relative "Category"

class TestProduct < Minitest::Test
  
  def setup
    DATABASE.execute("DELETE from products")
    #DATABASE.execute("DELETE from catergories")
    DATABASE.execute("DELETE from locations")
  end
  
  def test_simple_thing
    assert_equal(1, 1)
  end
  
  def test_insert_product
    t = Product.new({"serial_number" => "77sdfd7", "name" => "bread",
        "description" => "sliced", "cost" => 300, "quantity" => 100})
  t.insert
  refute_equal([], DATABASE.execute("SELECT * FROM products"))
  end
end#classend

