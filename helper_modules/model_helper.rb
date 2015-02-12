module ModelHelper
  
  # #Public: #edit_object
 #  Changes an object's attributes to the values given.
 #
 #  Parameters:
 #  params     - Hash: a hash containing the attributes being changed and their values.
 #  thaw_field - String: an unfrozen version of the field key with @ inserted.
 #
 #  Returns:
 #  nil
 #
 #  State Changes:
 #  Changes all attributes in the object that are present in params.
  
  
  def edit_object(params)
    params.each do |field, value|
      thaw_field = field.dup.insert(0, "@")
      self.instance_variable_set(thaw_field, value) if value != ""
    end
  end
  
  # Public: #display_attributes
   # Returns the attributes of an object as a table.
   #
   # Parameters:
   # attributes              - Array: an array for the column headings      
   #
   # Returns:
   # Table -  String:  a detailed table for the object
   #
   # State changes:
   # creates a new row in table for each attribute of the object.
  
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