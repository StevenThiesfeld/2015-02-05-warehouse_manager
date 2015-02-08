# Class: Location
#
# Stores the warehouse locations for the products.
#
# Attributes:
# @options         - Hash: stores the information about each product, including:
#  
# @serial_number   - The product number/sku for the item in the warehouse.
# @name            - The name of the product.
# @description     - A description of the product.
# @cost            - The price of the product
# @quantity        - The quantity on hand.
# @location_id     - The location in the warehouse where the product is kept.
# @category_id     - The category in the store to which the item belongs.
#
#
# Public Methods:
# #save
# .find
# .delete_record
# #insert
# #
# 

class Location
  include DatabaseMethods
  extend ClassMethods
  attr_reader :id
  attr_accessor :name
  
  def initialize(options)
    @id = options["id"]
    @name = options["name"]
  end
  
 # Public: .delete_record
 # Deletes a location only if it is empty.
 #
 # Parameters:
 # id_to_remove           - Integer: The id of the location to delete.
 #
 # Returns:
 # nil
 #
 # State Changes:
 # Entry deleted from locations table.
   
  def self.delete_record(id_to_remove)
    if DATABASE.execute("SELECT id FROM products WHERE location_id = #{id_to_remove}") == []
    DATABASE.execute("DELETE FROM locations WHERE #{id_to_remove} = id")
    end
  end
    
end#classend