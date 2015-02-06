class Product
  attr_reader :id, :serial_number, :name, :description, :cost, :quantity, :location_id, :category_id
  def initialize(options)
    @serial_number = options[:serial_number]
    @name = options[:name]
    @description = options[:name]
    @cost = options[:cost]
    @quantity = options[:quantity]
    @location_id = options[:location_id]
    @category_id = options[:category_id]
  end
   
  def self.edit_record(changed_item, column_name, new_value)
    DATABASE.execute("UPDATE products SET '#{column_name}' = '#{new_value}' 
                      WHERE id = #{changed_item} ")
  end
  
  def self.delete_record(id_to_remove)
    DATABASE.execute("DELETE FROM products WHERE id = #{id_to_remove}")
  end
  
 
  end
  
  def insert_record 
    attributes = []
    values = []
    instance_variables.each do |i|
      attributes << i.to_s.delete("@") 
    end
        
    attributes.each do |a|
      value = self.send(a)
      
      if value.is_a?(Integer)
        values << "#{value}"
      else values << "'#{value}'"
      end
    end
      
    DATABASE.execute("INSERT INTO products (#{attributes.join(", ")}) VALUES
                       (#{values.join(", ")})")
    @id = DATABASE.last_insert_row_id  
end
# '#{@serial_number}', '#{@name}', '#{@description}',
#                         '#{@cost}', '#{@quantity}',
#                         '#{@location_id}', '#{@category_id}'