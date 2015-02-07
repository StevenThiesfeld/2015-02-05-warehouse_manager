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
    @serial_number = options["serial_number"]
    @name = options["name"]
    @description = options["description"]
    @cost = options["cost"]
    @quantity = options["quantity"]
    @location_id = options["location_id"]
    @category_id = options["category_id"]
    @id = options["id"]
  end
   
  #make like save method
  # def save(table)
#     attributes = []
#
#     # Example  [:@serial_number, :@name, :@description]
#     instance_variables.each do |i|
#       # Example  :@name
#       attributes << i.to_s.delete("@") # "name"
#     end
#
#     query_components_array = []
#
#     attributes.each do |a|
#       value = self.send(a)
#
#       if value.is_a?(Integer)
#         query_components_array << "#{a} = #{value}"
#       else
#         query_components_array << "#{a} = '#{value}'"
#       end
#     end
#
#     query_string = query_components_array.join(", ")
#
#     DATABASE.execute("UPDATE #{table} SET #{query_string} WHERE id = #{id}")
#   end
   
  def self.find(id_to_find)
    result = DATABASE.execute("SELECT * FROM products WHERE id = #{id_to_find}")
    record_details = result[0]
    self.new(record_details)
  end
  
  # #searches for products based on a user's selected field
 #  def self.search_where(table, search_for, user_search)
 #    search = nil
 #    if user_search.is_a?(Integer)
 #      search = user_search
 #    else search = "'#{user_search}'"
 #    end
 #
 #    search_results = []
 #    results = DATABASE.execute("SELECT * FROM products WHERE #{search_for} = #{search}")
 #    results.each do |r|
 #      search_results << self.new(r)
 #    end
 #    search_results
 #  end
  
  #shouldn't need much else.
  # def self.delete_record(id_to_remove)
#     DATABASE.execute("DELETE FROM products WHERE id = #{id_to_remove}")
#   end
  
  # def insert
  #   DATABASE.execute("INSERT INTO products (serial_number, name, description,
  #                                      cost, quantity, location_id, category_id)
  #                                       VALUES ('#{@serial_number}', '#{@name}',
  #                                        '#{@description}', #{@cost}, #{@quantity},
  #                                         #{@location_id}, #{@category_id})")
  #   @id = DATABASE.last_insert_row_id
  # end
  
end#classend

# attributes = []
# values = []
# instance_variables.each do |i|
#   attributes << i.to_s.delete("@")
# end
#
# attributes.each do |a|
#   value = self.send(a)
#
#   if value.is_a?(Integer)
#     values << "#{value}"
#   else values << "'#{value}'"
#   end
# end
#
