require 'pry'
require 'db_setup'
class Product
  def initialize(options)
    @serial_number = options[:serial_number]
    @name = options[:name]
    @description = options[:name]
    @cost = options[:cost]
    @quantity = options[:quantity]
    @location_id = options[:location_id]
    @category_id = options[:category_id]
  end
   
  def edit_record(changed_item, column_name, new_value)
    DATABASE.execute("UPDATE products SET '#{column_name}' = '#{new_value}' 
                      WHERE id = '#{changed_item}' ")
  end
  
  
    
  
  private
  def save 
    DATABASE.execute("INSERT INTO products (serial_number, name, description,
                      cost, quantity, location_id, category_id) VALUES
                       ('#{@serial_number}', '#{@name}', '#{@description}',
                        '#{@cost}', '#{@quantity}',
                        '#{@location_id}', '#{@category_id}')")
  end
  
end
binding.pry