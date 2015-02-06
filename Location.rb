class Location
  attr_reader :id
  attr_accessor :name
  
  def initialize(options)
    @name = options["name"]
    @id = options["id"]
  end
  
  def self.find(search_for, user_search)
    if user_search.is_a?(Integer)
      search = "#{user_search}"
    else search = "'#{user_search}'"
    result = DATABASE.execute("SELECT * FROM locations WHERE '#{search_for}' = #{search}")
    record_details = result[0]
    self.new(record_details)
    end
  end
      
  def save
    attributes = []

    # Example  [:@serial_number, :@name, :@description]
    instance_variables.each do |i|
      # Example  :@name
      attributes << i.to_s.delete("@") # "name"
    end
  
    query_components_array = []

    attributes.each do |a|
      value = self.send(a)

      if value.is_a?(Integer)
        query_components_array << "#{a} = #{value}"
      else
        query_components_array << "#{a} = '#{value}'"
      end
    end

    query_string = query_components_array.join(", ")

    DATABASE.execute("UPDATE locations SET #{query_string} WHERE id = #{id}")
  end
  
  def self.delete_record(id_to_remove)
    if DATABASE.execute("SELECT id FROM products WHERE location_id = #{id_to_remove}") == []
    DATABASE.execute("DELETE FROM locations WHERE #{id_to_remove} = id")
    end
  end
    
  def insert
    # attributes = []
   #  values = []
   #      # Example  [:@name, :@age, :@hometown]
   #  instance_variables.each do |i|
   #        # Example  :@name
   #    attributes << i.to_s.delete("@") # "name"
   #  end
   #
   #  attributes.each do |a|
   #    value = self.send(a)
   #
   #    if value.is_a?(Integer)
   #      values << "#{value}"
   #    else values << "'#{value}'"
   #    end
   #  end
      
    DATABASE.execute("INSERT INTO locations (name) VALUES ('#{@name}')")
    @id = DATABASE.last_insert_row_id  
  end
    
  
end#classend