class Location
  attr_reader :name, :id
  def initialize(options)
    @name = options[:name]
  end
    
  def save_record
    save
  end
  
  def self.edit_record(changed_item, column_name, new_value)
    DATABASE.execute("UPDATE locations SET '#{column_name}' = '#{new_value}' 
                      WHERE id = '#{changed_item}' ")
  end 
  
  def self.delete_record(id_to_remove)
    DATABASE.execute("DELETE FROM locations WHERE #{id_to_remove} = id")
  end
    
  private
  def save 
    attributes = []
    values = []
        # Example  [:@name, :@age, :@hometown]
    instance_variables.each do |i|
          # Example  :@name
      attributes << i.to_s.delete("@") # "name"
    end
        
    attributes.each do |a|
      value = self.send(a)
      
      if value.is_a?(Integer)
        values << "#{value}"
      else values << "'#{value}'"
      end
    end
      
    DATABASE.execute("INSERT INTO locations (#{attributes.join(", ")}) VALUES
                       (#{values.join(", ")})")
    @id = DATABASE.last_insert_row_id  
end
    
  
end

