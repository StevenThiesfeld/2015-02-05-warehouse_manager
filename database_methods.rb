module DatabaseMethods
  
  def insert(table) 
    attributes = []
    values = []
    instance_variables.each do |i|
    
      attributes << i.to_s.delete("@") if i != :@id
    end

    attributes.each do |a|
      value = self.send(a)

      if value.is_a?(Integer)
        values << "#{value}"
      else values << "'#{value}'"
      end
    end
    DATABASE.execute("INSERT INTO #{table} (#{attributes.join(", ")})
                                        VALUES (#{values.join(", ")})")
    @id = DATABASE.last_insert_row_id  
  end
  
  def save(table)
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

    DATABASE.execute("UPDATE #{table} SET #{query_string} WHERE id = #{id}")
  end
  
end#module_end

module ClassMethods
  
  def delete_record(table, id_to_remove)
    DATABASE.execute("DELETE FROM #{table} WHERE id = #{id_to_remove}")
  end
  
  #searches for products based on a user's selected field
  def search_where(table, search_for, user_search)
    if user_search.is_a?(Integer)
      search = user_search
    else search = "'#{user_search}'"
    end
      
    search_results = []
    results = DATABASE.execute("SELECT * FROM products WHERE #{search_for} = #{search}")
    results.each do |r|
      search_results << self.new(r)
    end
    search_results
  end
  
end#module_end

