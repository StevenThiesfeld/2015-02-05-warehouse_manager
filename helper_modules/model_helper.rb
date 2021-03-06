module ModelHelper
    
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