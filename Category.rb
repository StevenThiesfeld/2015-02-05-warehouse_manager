# Class: Category
#
# Stores the categories for the products.
#
# Attributes:
# @id                - Integer: The id number of the Object.
# @name              - String: The name of the Object. 
#
#
# Public Methods:
# .delete_record
# #
# 
class Category
  include DatabaseMethods
  extend ClassMethods
  attr_reader :id
  attr_accessor :name
  
  def initialize(options)
    @id = options["id"]
    @name = options["name"] 
  end
  
  # Public: .delete_record
   # Deletes a category only if it is empty.
   #
   # Parameters:
   # id_to_remove           - Integer: The id of the category to delete.
   #
   # Returns:
   # nil
   #
   # State Changes:
   # Entry deleted from categories table.
  
  def self.delete_record(id_to_remove)
    if DATABASE.execute("SELECT id FROM products WHERE location_id = #{id_to_remove}") == []
    DATABASE.execute("DELETE FROM categories WHERE #{id_to_remove} = id")
    end
  end
  
  
end#classend