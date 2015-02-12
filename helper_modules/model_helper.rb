module ModelHelper
  
  def edit_object(params)
    params.each do |field, value|
      thaw_field = field.dup.insert(0, "@")
      self.instance_variable_set(thaw_field, value) if value != ""
    end
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
  
end#module end