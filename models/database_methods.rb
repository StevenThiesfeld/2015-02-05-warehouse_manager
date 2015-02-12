# Module: DatabaseMethods
#
# Tracks items in the grocery warehouse.
#
# Attributes:
#  
#
#
# Public Methods:
# #insert
# #save
# #list_attributes_no_id
# #display_attributes
# #
# 
module DatabaseMethods
  
  # Public: insert
   # Inserts the newly created item into the database.
   #
   # Parameters:
   # table               - String: the table being added to.
   # attributes          - Array: A list of the attributes being added.
   # values              - Array: A list of the values of the attributes.
   #
   # Returns: 
   # @id the primary key for the product key.
   #
   # State changes:
   # Selected values are updated in the database.
  
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
  
  # Public: #save
   # Saves the updated records.
   #
   # Parameters:
   # table                   - String: the table that is being saved to.
   # attributes              - Array: an array for the column headings                                            (attributes).
   # query_components_array: - Array:  an array for the search values.
   # changed_item            - String: the old value in the record.
   #
   #
   # Returns:
   # nil
   #
   # State changes:
   # Updates the records in the database.
   
  
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
  
  
  
  def list_attributes_no_id
    attributes = []

    # Example  [:@serial_number, :@name, :@description]
    instance_variables.each do |i|
      # Example  :@name
      attributes << i.to_s.delete("@") if i != :@id
    end
    attributes
  end
  
  def list_attributes_with_id
    attributes = []

    # Example  [:@serial_number, :@name, :@description]
    instance_variables.each do |i|
      # Example  :@name
      attributes << i.to_s.delete("@")
    end
    attributes
  end
  
  # Public: #display_attributes
   # Displays all the attributes for the selected rows.
   #
   # Parameters:
   # attributes              - Array: an array for the column headings      
   #
   # Returns:
   # nil
   #
   # State changes:
   # none.
  
  def display_attributes
     attributes = []
     instance_variables.each do |i|
       # Example  :@name
       attributes << i.to_s.delete("@")
     end
    table = "<table><tr><th>FIELD</th><th>VALUE</th></tr>"
    attributes.each do |a|
      table += "<tr><td>#{a}</td><td>#{self.send(a)}</td></tr>"
    end
    table +="</table>"
    table
  end
    
  
end#module_end

module ClassMethods
  
  # Public: .delete_record
    # Deletes item(s) from the database based on the search criteria.
    #
    # Parameters:
    # table                 - String:  the table the method is working in.
    # id_to_remove          - Integer: ID value of the rows to delete.
    # 
    #
    # Returns: 
    # none
    #
    # State changes:
    # Values are deleted from the database.
  
  def delete_record(table, id_to_remove)
    DATABASE.execute("DELETE FROM #{table} WHERE id = #{id_to_remove}")
  end
  
  # Public: .search_where
    # Fetches items from the database based on the search criteria.
    #
    # Parameters:
    # table                 - String: the table being searched.
    # search_for            - key(column) to search.
    # user_search           - The value to match.
    # search                - User_search formatted.
    # search_results        - Array: The search results based on the search_for                                  criteria.   
    # Returns: 
    # returns the search_results array.
    #
    # State changes:
    # none.
  
  def search_where(table, search_for, user_search)
    if user_search.is_a?(Integer)
      search = user_search
    else search = "'#{user_search}'"
    end
      
    search_results = []
    results = DATABASE.execute("SELECT * FROM #{table} WHERE #{search_for} = #{search}")
    results.each do |r|
      search_results << self.new(r) if r != nil
    end
    search_results
  end
  
  # Public: .find
    # Fetches items from the database based on the search criteria.
    #
    # Parameters:
    # table               - String:  the table being searched.
    # id_to_find          - Integer: the id number to search for in the                                        database.
    # result              - Array: an array to hold the search results.
    # record_details      - Array: an array to hold the first row of the results.
    #
    #
    # Returns:
    # returns the matching record for the specified ID.
    #
    # State changes:
    # none.
  
  
  def find(table, id_to_find)
    result = DATABASE.execute("SELECT * FROM #{table} WHERE id = #{id_to_find}")
    record_details = result[0]
    self.new(record_details) if record_details != nil
  end
  
  def all(table)
    locations = []
    results = DATABASE.execute("SELECT * FROM #{table}")
    results.each do |result|
      locations << self.new(result) if result != nil
    end
    locations
  end
  
  
end#module_end

