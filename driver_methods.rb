module DriverMethods
  
  def menu_prompt
    puts "WELCOME TO THE WAREHOUSE MANAGEMENT SUITE"
    puts "-"*60
    puts "TO CREATE, EDIT OR DELETE A LOCATION: TYPE 1"
    puts "-"*60
    puts "TO CREATE, EDIT OR DELETE A PRODUCT: TYPE 2"
    puts "-"*60
    puts "TO CREATE, EDIT OR DELETE A CATEGORY: TYPE 3"
    puts "-"*60
    puts "TO RUN A SEARCH: TYPE 4"
    puts "-"*60
    puts "TYPE QUIT TO EXIT THE PROGRAM"
  end
  
  def submenu(var)
    puts "TO CREATE A NEW #{var}: TYPE 1"
    puts "-"*60
    puts "TO EDIT AN EXISTING #{var}: TYPE 2"
    puts "-"*60
    puts "TO DELETE A #{var}: TYPE 3"
    puts "-"*60
    puts "TO RETURN TO THE PREVIOUS MENU: TYPE ANYTHING ELSE"
  end  

  def add_location
    puts "ENTER LOCATION NAME"
    name = gets.chomp
    location = Location.new("name" => name)
    puts "YOU HAVE ENTERED #{location.name}"
    puts "IF THIS IS CORRECT PRESS 1"
    puts "IF THIS IS INCORRECT PRESS ANYTHING OTHER THAN 1 TO CANCEL CREATION"
    verify = gets.chomp
    if verify == "1"
      location.insert("locations")
      puts "LOCATION SAVED TO ID ##{location.id}"
    else puts "PROCESS CANCELLED"
    end
  end
  
  def edit_location
    location_list
    puts "ENTER LOCATION TO EDIT(BY NUMBER)"
    location_to_edit = gets.to_i
    location = Location.find("locations", location_to_edit)
    location.list_attributes.each do |a|
      puts "--#{a}--"
    end
    to_edit = ""
    until to_edit.downcase == "no"
      puts "ENTER FIELD TO EDIT"
      raw_edit = gets.chomp
      to_edit = raw_edit.insert(0, "@")
      puts "ENTER CHANGE"
      raw_change = gets.chomp
      raw_change.to_i == 0 ? change = raw_change : change = raw_change.to_i
      location.instance_variable_set(to_edit, change)
      puts "EDIT ANOTHER FIELD?"
      to_edit = gets.chomp
    end
    puts "PRESS 1 TO SAVE CHANGES, PRESS ANYTHING ELSE TO CANCEL"
    verify = gets.chomp
    if verify == "1"
      location.save("locations")
      puts "CHANGES SAVED"
    else puts "PROCESS CANCELLED"
    end
  end
  
  def delete_location
    puts "ENTER LOCATION ID TO DELETE"
    location_to_delete = gets.to_i
    puts "ARE YOU SURE YOU WANT TO DO THIS?"
    puts "PRESS 1 TO CONTINUE, PRESS ANYTHING OTHER THAN 1 TO CANCEL DELETION"
    verify = gets.chomp
    if verify == "1"
      Location.delete_record(location_to_delete)
      puts "LOCATION ID #{location_to_delete} DELETED"
    else puts "PROCESS CANCELLED"
    end
  end    
  
  def add_product
    good_serial = 0
    good_name = 0
    good_description = 0
    good_cost = 0
    good_quantity = 0
    good_location_id = 0
    good_category_id = 0
      
    until good_serial == 1
      puts "ENTER PRODUCT SERIAL NUMBER"
      serial_number = gets.chomp
      if !serial_number.empty?
        good_serial = 1
      else puts "ERROR. INVALID INPUT."
      end
    end
    
    until good_name == 1      
      puts "ENTER PRODUCT NAME"
      name = gets.chomp
      if !name.empty?
        good_name = 1
      else puts "ERROR. INVALID INPUT."
      end
    end
    
    until good_description == 1      
      puts "ENTER PRODUCT DESCRIPTION"
        description = gets.chomp
      if !description.empty?
        good_description = 1
      else puts "ERROR. INVALID INPUT."
      end
    end
    
    until good_cost == 1      
      puts "ENTER PRODUCT COST"
        cost = gets.to_i
      if cost != 0
        good_cost = 1
      else puts "ERROR. INVALID INPUT."
      end
    end
    
    until good_quantity == 1      
      puts "ENTER PRODUCT QUANTITY"
        quantity = gets.to_i
      if quantity >= 0
        good_quantity = 1
      else puts "ERROR. INVALID INPUT."
      end
    end
    
    location_list
    
    until good_location_id == 1  
      puts "ASSIGN NEW PRODUCT TO A LOCATION(BY NUMBER)"
        location_id = gets.to_i
      if location_id >= 0
        good_location_id = 1
      else puts "ERROR. INVALID INPUT."
      end
    end
    
    category_list
    
    until good_category_id == 1      
      puts "ASSIGN NEW PRODUCT TO LOCATION(BY NUMBER)"
        category_id = gets.to_i
      if category_id >= 0
        good_category_id = 1
      else puts "ERROR. INVALID INPUT."
      end
    end
    
    new_product = Product.new({"serial_number" => serial_number, "name" => name,
       "description" => description, "cost" => cost, "quantity" => quantity,
        "location_id" => location_id, "category_id" => category_id })
    
    puts "PRESS 1 TO SAVE PRODUCT"
    puts "PRESS ANYTHING OTHER THAN 1 TO CANCEL CREATION"
    verify = gets.chomp
    if verify == "1"
      new_product.insert("products")
      puts "PRODUCT SAVED, PRODUCT ID IS #{new_product.id}"
    else puts "PROCESS CANCELLED"
    end
  end
  
  def location_list
    locations = DATABASE.execute("SELECT * FROM locations")  
    locations.each do |l|
      puts "#{l["id"]}---------#{l["name"]}"
    end
  end
  
  def category_list
    categories = DATABASE.execute("SELECT * FROM categories")  
    categories.each do |c|
      puts "#{c["id"]}---------#{c["name"]}"
    end
  end
    
end#module_end