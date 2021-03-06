require 'sqlite3'
require 'pry'
DATABASE = SQLite3::Database.new('../database/test_warehouse_database.db')
require 'minitest/autorun'
require_relative "../database/database_methods"
require_relative "../helper_modules/model_helper"
require_relative '../database/db_setup'
require_relative "../models/product"
require_relative "../models/location"
require_relative "../models/category"

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
  t.insert("products")
  refute_equal([], DATABASE.execute("SELECT * FROM products"))
  end
  
  def test_save_product
    t = Product.new({"serial_number" => "77sdfd7", "name" => "bread",
        "description" => "sliced", "cost" => 300, "quantity" => 100,
         "location_id" => 0, "category_id" => 0})
    t.insert("products")
    t.name = "good bread"
    t.save("products")
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
    t1.insert("products")
    t2.insert("products")
    test3 = Product.search_where("products", "location_id", 1)
    
    assert_equal(2, test3.length)    
  end
    
  def test_delete_record
    DATABASE.execute("DELETE FROM products")
    t1 = Product.new({"serial_number" => "1111", "name" => "zombie",
        "description" => "sliced", "cost" => 300, "quantity" => 100,
         "location_id" => 1, "category_id" => 2})
    t1.insert("products")
    Product.delete_record("products", 1)
    assert_equal([], DATABASE.execute("SELECT * FROM products")) 
  end    
    
end#classend

class TestLocation < Minitest::Test
  
  def setup
    DATABASE.execute("DELETE from products")
    #DATABASE.execute("DELETE from categories")
    DATABASE.execute("DELETE from locations")
  end
  
  
  def test_delete_location
    test_site = Location.new("test site")
    test_site2 = Location.new("test site2")
    test_site.insert("locations")
    test_site2.insert("locations")
    t1 = Product.new({"serial_number" => "77sdfd7", "name" => "bread",
        "description" => "sliced", "cost" => 300, "quantity" => 100,
         "location_id" => 1, "category_id" => 2})
    t1.insert("products")    
    Location.delete_record(1)
    Location.delete_record(2)
    refute_equal([], DATABASE.execute("SELECT * FROM locations WHERE id = 1"))
    assert_equal([], DATABASE.execute("SELECT * FROM locations WHERE id = 2"))
  end
  
  
end#classend

class TestModelHelper < Minitest::Test
  include ModelHelper
  
  def setup
    DATABASE.execute("DELETE from products")
    #DATABASE.execute("DELETE from categories")
    DATABASE.execute("DELETE from locations")
  end
  
  def test_edit_object
    test_site = Location.new({"name" => "Test Site"})
    params = {"name" => "it works"}
    test_site.edit_object(params)
    assert_equal("it works", test_site.name)
  end
  
  def test_display_attributes
    test = Product.new({"serial_number" => "77sdfd7", "name" => "bread",
        "description" => "sliced", "cost" => 300, "quantity" => 100,
         "location_id" => 1, "category_id" => 2})
      
    table = test.display_attributes
    assert_kind_of(String, table)  
  end
  
  
end#classend
    
    
