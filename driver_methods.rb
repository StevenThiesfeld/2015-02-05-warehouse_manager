module DriverMethods
  
  def menu_prompt
    puts "WELCOME TO THE WAREHOUSE MANAGEMENT SUITE"
    puts "-"*60
    puts "TO CREATE, EDIT, DELETE OR FETCH A LOCATION: TYPE 1"
    puts "-"*60
    puts "TO CREATE, EDIT, DELETE OR FETCH A PRODUCT: TYPE 2"
    puts "-"*60
    puts "TO CREATE, EDIT, DELETE OR FETCH A CATEGORY: TYPE 3"
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
    puts "TO FETCH A SPECIFIC #{var}: TYPE 4"
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
       puts "HERE IS THE NEW LOCATIONS LIST:\n"
       location_list
     else puts "PROCESS CANCELLED"
     end
   end
  
   def edit_location
     location_list
     puts "ENTER LOCATION TO EDIT(BY NUMBER)"
     location_to_edit = gets.to_i
     location = Location.find("locations", location_to_edit)
     location.display_attributes
     raw_field = ""
     until raw_field.downcase == "done"
       puts "ENTER FIELD TO EDIT"
       raw_field = gets.chomp
       puts "ENTER CHANGE"
       raw_change = gets.chomp
       verify_edit(location, raw_field, raw_change)
       puts "ENTER ANOTHER FIELD TO EDIT(TYPE DONE TO FINISH)"
       raw_field = gets.chomp
     end
     puts "PRESS 1 TO SAVE CHANGES, PRESS ANYTHING ELSE TO CANCEL"
     verify = gets.chomp
     if verify == "1"
       location.save("locations")
       puts "CHANGES SAVED"
       puts "HERE IS THE UPDATED LOCATIONS LIST:\n"
       location_list
     else puts "PROCESS CANCELLED"
     end
  end
  
  def delete_location
     location_list
     puts "ENTER LOCATION ID TO DELETE"
     location_to_delete = gets.to_i
     puts "ARE YOU SURE YOU WANT TO DO THIS?"
     puts "PRESS 1 TO CONTINUE, PRESS ANYTHING OTHER THAN 1 TO CANCEL DELETION"
     verify = gets.chomp
     if verify == "1"
       Location.delete_record(location_to_delete)
       puts "LOCATION ##{location_to_delete} DELETED"
     else puts "PROCESS CANCELLED"
     end
     puts "UPDATED LOCATIONS LIST:\n"
     location_list
   end
   
   def fetch_location
     location_list
     puts "TYPE THE ID OF WHAT YOU WANT TO SEE IN DETAIL"
     fetch = gets.to_i
     result = Location.find("locations", fetch)
     result.display_attributes
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
       if cost >= 0
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
       if Location.find("locations", location_id) != nil
         good_location_id = 1
       else puts "ERROR. LOCATION DOES NOT EXIST."
       end
     end
  
     category_list
  
     until good_category_id == 1      
       puts "ASSIGN NEW PRODUCT TO A CATEGORY(BY NUMBER)"
         category_id = gets.to_i
       if Category.find("categories", category_id) != nil
         good_category_id = 1
       else puts "ERROR. CATEGORY DOES NOT EXIST."
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
       puts "HERE IS THE NEW PRODUCTS LIST:\n"
       product_list
     else puts "PROCESS CANCELLED"
     end
  end
  
  def edit_product
    product_list
    puts "ENTER PRODUCT TO EDIT(BY NUMBER)"
    product_to_edit = gets.to_i
    product = Product.find("products", product_to_edit)
    product.display_attributes
    raw_field = ""
    until raw_field.downcase == "done"
      puts "ENTER FIELD TO EDIT"
      raw_field = gets.chomp
      puts "ENTER CHANGE"
      raw_change = gets.chomp
      verify_edit(product, raw_field, raw_change)
      puts "ENTER ANOTHER FIELD TO EDIT(TYPE DONE TO FINISH)"
      raw_field = gets.chomp
    end
    puts "PRESS 1 TO SAVE CHANGES, PRESS ANYTHING ELSE TO CANCEL"
    verify = gets.chomp
    if verify == "1"
      product.save("products")
      puts "CHANGES SAVED"
      puts "HERE IS THE UPDATED PRODUCT INFORMATION:\n"
      product.display_attributes
    else puts "PROCESS CANCELLED"
    end
  end
  
  def delete_product
     product_list
     puts "ENTER PRODUCT ID TO DELETE"
     product_to_delete = gets.to_i
     puts "ARE YOU SURE YOU WANT TO DO THIS?"
     puts "PRESS 1 TO CONTINUE, PRESS ANYTHING OTHER THAN 1 TO CANCEL DELETION"
     verify = gets.chomp
     if verify == "1"
       Product.delete_record("products", product_to_delete)
       puts "PRODUCT ##{product_to_delete} DELETED"
       product_list
     else puts "PROCESS CANCELLED"
     end
   end 
   
   def fetch_product
     product_list
     puts "TYPE THE ID OF WHAT YOU WANT TO SEE IN DETAIL"
     fetch = gets.to_i
     result = Product.find("products", fetch)
     result.display_attributes
   end   
  
  def add_category
    puts "ENTER CATEGORY NAME"
    name = gets.chomp
    category = Category.new("name" => name)
    puts "YOU HAVE ENTERED #{category.name}"
    puts "IF THIS IS CORRECT PRESS 1"
    puts "IF THIS IS INCORRECT PRESS ANYTHING OTHER THAN 1 TO CANCEL CREATION"
    verify = gets.chomp
    if verify == "1"
      category.insert("categories")
      puts "LOCATION SAVED TO ID ##{category.id}"
    else puts "PROCESS CANCELLED"
    end
  end  
  
  def edit_category
    category_list
    puts "ENTER CATEGORY TO EDIT(BY NUMBER)"
    category_to_edit = gets.to_i
    category = Category.find("categories", category_to_edit)
    category.display_attributes
    raw_field = ""
    until raw_field.downcase == "done"
      puts "ENTER FIELD TO EDIT"
      raw_field = gets.chomp
      puts "ENTER CHANGE"
      raw_change = gets.chomp
      verify_edit(category, raw_field, raw_change)
      puts "ENTER ANOTHER FIELD TO EDIT(TYPE DONE TO FINISH)"
      raw_field = gets.chomp
    end
    puts "PRESS 1 TO SAVE CHANGES, PRESS ANYTHING ELSE TO CANCEL"
    verify = gets.chomp
    if verify == "1"
      category.save("categories")
      puts "CHANGES SAVED"
    else puts "PROCESS CANCELLED"
    end
  end
  
  def delete_category
    category_list
    puts "ENTER CATEGORY ID TO DELETE"
    category_to_delete = gets.to_i
    puts "ARE YOU SURE YOU WANT TO DO THIS?"
    puts "PRESS 1 TO CONTINUE, PRESS ANYTHING OTHER THAN 1 TO CANCEL DELETION"
    verify = gets.chomp
    if verify == "1"
      Category.delete_record(category_to_delete)
      puts "CATEGORY ##{category_to_delete} DELETED"
    else puts "PROCESS CANCELLED"
    end
  end  
  
  def fetch_category
    category_list
    puts "TYPE THE ID OF WHAT YOU WANT TO SEE IN DETAIL"
    fetch = gets.to_i
    result = Category.find("categories", fetch)
    result.display_attributes
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
  
  def product_list
    products = DATABASE.execute("SELECT * FROM products")
    products.each do |p|
      puts "#{p["id"]}---------#{p["name"]}"
    end
  end
  
  def verify_edit(object, raw_field, raw_change)
    if object.list_attributes_no_id.include?(raw_field)
      good_change = false
      case raw_field
      when "cost", "quantity"
        if raw_change.to_i >= 0
          change = raw_change.to_i 
          good_change = true
        else puts "INVALID ENTRY"
        end
      
      when "location_id"
        if Location.find("locations", raw_change.to_i) != nil
          change = raw_change.to_i
          good_change = true
        else puts "THAT LOCATION DOES NOT EXIST"
        end
      
      when "category_id"
        if Category.find("categories", raw_change.to_i) != nil
          change = raw_change.to_i
          good_change = true
        else puts "THAT CATEGORY DOES NOT EXIST"
        end  
      else 
        if raw_change.length != 0
          change = raw_change
          good_change = true
        else puts "INVALID ENTRY"
        end
      end 
          
      field = raw_field.insert(0, "@")
      enter_edit(object, field, change) if good_change == true
    else puts "INVALID FIELD"
    end
  end

  def enter_edit(object, field, change)
    object.instance_variable_set(field, change)
  end
  
  def search_submenu
    puts "TO RUN A GENERAL SEARCH PRESS 1"
    puts "TO SEARCH FOR ALL PRODUCTS IN A LOCATION PRESS 2"
    puts "TO SEARCH FOR ALL PRODUCTS IN A CATEGORY PRESS 3"
  end
  def general_search
    puts "WHICH TABLE WOULD YOU LIKE TO SEARCH: 1-LOCATIONS, 2-PRODUCTS, OR 3-CATEGORIES?"
    puts "-"*60
    search = gets.chomp 
    case search
    when "1"
      puts "ENTER SEARCH FIELD"
      puts "(id, name)"
      field = gets.chomp
      puts "ENTER SEARCH TERM"
      look_for = gets.chomp 
      results = Location.search_where("locations", field, look_for)
      results.each do |r|
        r.display_attributes
      end
      
    when "2"
      puts "ENTER SEARCH FIELD"
      puts "(id, serial_number, name, description, cost, quantity, location_id, category_id)"
      field = gets.chomp
      puts "ENTER SEARCH TERM"
      look_for = gets.chomp
      results = Product.search_where("products", field, look_for)
      results.each do |r|
        r.display_attributes
      end
      
    when "3"
      puts "ENTER SEARCH FIELD"
      puts "(id, name)"
      field = gets.chomp
      puts "ENTER SEARCH TERM"
      look_for = gets.chomp
      results = Category.search_where("categories", field, look_for)
      results.each do |r|
        r.display_attributes
      end
    else puts "RETURNING TO MAIN MENU"
    end
  end
     
  def search_by_category
    category_list
    puts "SELECT A CATEGORY TO SEE ALL PRODUCTS IN THAT CATEGORY(USE ID)"
    search_in = gets.to_i
    results = Product.search_where("products", "category_id", search_in)
    results.each do |r|
      r.display_attributes
    end
  end
  
  def search_by_location
    location_list
    puts "SELECT A LOCATION TO SEE ALL PRODUCTS IN THAT LOCATION(USE ID)"
    search_in = gets.to_i
    results = Product.search_where("products", "category_id", search_in)
    results.each do |r|
      r.display_attributes
    end
  end
     
  
    
end#module_end