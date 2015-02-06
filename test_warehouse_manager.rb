require 'sqlite3'
require 'pry'
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
        "description" => "sliced", "cost" => 300, "quantity" => 100,
         "location_id" => 0, "category_id" => 0})
  t.insert
  refute_equal([], DATABASE.execute("SELECT * FROM products"))
  end
  
  def test_save_product
    t = Product.new({"serial_number" => "77sdfd7", "name" => "bread",
        "description" => "sliced", "cost" => 300, "quantity" => 100,
         "location_id" => 0, "category_id" => 0})
    t.insert
    t.name = "good bread"
    t.save
    test_result =  DATABASE.execute("SELECT name FROM products WHERE name = 'good bread'")
    assert_equal("good bread", test_result[0]["name"])
  end
  
  def test_search_where
    t1 = Product.new({"serial_number" => "77sdfd7", "name" => "bread",
        "description" => "sliced", "cost" => 300, "quantity" => 100,
         "location_id" => 1, "category_id" => 2})
    t2 = Product.new({"serial_number" => "1234", "name" => "green beans",
         "description" => "no salt", "cost" => 99, "quantity" => 50,
        "location_id" => 1, "category_id" => 1})
    t1.insert
    t2.insert
    test3 = Product.search_where("location_id", 1)
    
    assert_equal(2, test3.length)    
  end
    
    
    
    
  
end#classend

