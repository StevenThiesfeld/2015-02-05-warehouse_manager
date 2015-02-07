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
    @name = options["name"]
    @id = options["id"]
  end
  
  # def self.find(search_for, user_search)
 #    if user_search.is_a?(Integer)
 #      search = "#{user_search}"
 #    else search = "'#{user_search}'"
 #    result = DATABASE.execute("SELECT * FROM locations WHERE #{search_for} = #{search}")
 #    record_details = result[0]
 #    self.new(record_details)
 #    end
 #  end
      
  # # def save
 #    attributes = []
 #
 #    # Example  [:@serial_number, :@name, :@description]
 #    instance_variables.each do |i|
 #      # Example  :@name
 #      attributes << i.to_s.delete("@") # "name"
 #    end
 #
 #    query_components_array = []
 #
 #    attributes.each do |a|
 #      value = self.send(a)
 #
 #      if value.is_a?(Integer)
 #        query_components_array << "#{a} = #{value}"
 #      else
 #        query_components_array << "#{a} = '#{value}'"
 #      end
 #    end
 #
 #    query_string = query_components_array.join(", ")
 #
 #    DATABASE.execute("UPDATE locations SET #{query_string} WHERE id = #{id}")
 #  end
 
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
    
  # def insert
  #
  #   DATABASE.execute("INSERT INTO locations (name) VALUES ('#{@name}')")
  #   @id = DATABASE.last_insert_row_id
  # end
    
  
end#classend