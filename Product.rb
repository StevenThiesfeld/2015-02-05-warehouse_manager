# Class: Product
#
# Tracks items in the grocery warehouse.
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
# #edit_record
# #save
# #
# #
# #
# #
# #
# 

class Product
  include DatabaseMethods
  extend ClassMethods
  attr_reader :id
  attr_accessor  :serial_number, :name, :description, :cost, :quantity,
   :location_id, :category_id
   
  def initialize(options)
    @id = options["id"]
    @serial_number = options["serial_number"]
    @name = options["name"]
    @description = options["description"]
    @cost = options["cost"]
    @quantity = options["quantity"]
    @location_id = options["location_id"]
    @category_id = options["category_id"]
  end
     
end#classend