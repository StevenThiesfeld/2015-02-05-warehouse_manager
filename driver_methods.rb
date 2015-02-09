# Module: DriverMethodss
#
# Runs the methods for each menu chose the user makes.
#
# Attributes:
#
# Public Methods:
# #menu_prompt
# #submenu
# #add_location
# #edit_location
# #delete_location
# #fetch_location
# #add_product
# #edit_product
# #delete_product
# #fetch_product
# #add_category   
# #edit_category  
# #delete_category  
# #fetch_category
# #location_list
# #product_list
# #category_list
# #verify_edit
# #enter_edit
# #search_submenu 
# #general_search
# #search_by_category
# #search_by_location
#
module DriverMethods
  
  # Public: #menu_prompt
   # Prints out the main menu.
   #
   # Parameters:
   # none 
   #
   # Returns:
   # nil.
   #
   # State changes:
   # none
   
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
  
  # Public: #submenu
   # Calls the method to create new players, creates a new Game object, and then calls determine_winner to display the winner.
   #
   # Parameters:
   # none 
   #
   # Returns:
   # nil.
   #
   # State changes:
   # none
   
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

  # Public: #add_location
   # Adds a new location to the locations table.
   #
   # Parameters:
   # name        - String:  name of the location to be added.
   # location    - Object:  new location object.
   # verify      - String:  verifies good input.
   # Returns:
   # nil.
   #
   # State changes:
   # New Location is added to the database.

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
  
  # Public: #edit_location
  # Edits an existing location entry.
  #
  # Parameters:
  # location_to_edit    - Integer: The location selection to edit. 
  # location            - Object: The location object. 
  # raw_field           - String: The existing field to be edited.
  # raw_change          - String: The new value for that field.
  # verify              _ String: Verifies good input. 
  #
  # Returns:
  # nil.
  #
  # State changes:
  # The updated object is saved to the database.
  
  def edit_location
    location_list
    puts "ENTER LOCATION TO EDIT(BY NUMBER)"
    location_to_edit = gets.to_i
    location = Location.find("locations", location_to_edit)
    location.display_attributes
    raw_field = ""
    puts "ENTER FIELD TO EDIT"
    raw_field = gets.chomp
    until raw_field.downcase == "done"
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
  
  # Public: #delete_location
   # Deletes a location from the locations table.
   #
   # Parameters:
   # location_to_delete      - Integer: The location ID of the location to                                          delete. 
   # verify                  _ String: If "1", confirms the deletion, otherwise, cancels.
   #
   # Returns:
   # nil.
   #
   # State changes:
   # The selected location is deleted from the database.
   
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
  
  # Public: #fetch_location
   # Fetches the location the user wants to see.
   #
   # Parameters:
   # fetch         - Integer: The selection for which location to fetch.
   #
   # Returns:
   # nil.
   #
   # State changes:
   # none
   
   def fetch_location
     location_list
     puts "TYPE THE ID OF WHAT YOU WANT TO SEE IN DETAIL"
     fetch = gets.to_i
     result = Location.find("locations", fetch)
     result.display_attributes
   end
   
   # Public: #add_product
    # Adds a new product to the products table.
    #
    # Parameters:
    # good_serial
    # good_name
    # good_description
    # good_cost
    # good_quantity
    # good_location_id
    # good_category_id        - Integer:  All to verify each piece of data is in                                      valid parameters.
    # serial_number           - String: The serial id for the new product.
    # name                    - String: The name for the new product.
    # description             - String: The description for the new product.
    # cost                    - Integer: The cost for the new product.
    # quantity                - Integer: The current quantity for the new product.
    # location_id             - Integer: The location_id for the new product.
    # category_id             - Integer: The category_id for the new product.
    #
    # Returns:
    # nil.
    #
    # State changes:
    # New product is added to the products table.
   
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
  
  # Public: #edit_product
  # Edits the fields of an existing product.
  #
  # Parameters:
  # product_to_edit     - Integer: The product selection to edit. 
  # product             - Object: The product object. 
  # raw_field           - String: The existing field to be edited.
  # raw_change          - String: The new value for that field.
  # verify              _ String: Verifies good input. 
  #
  # Returns:
  # nil.
  #
  # State changes:
  # The updated object is saved to the database.
  
  def edit_product
    product_list
    puts "ENTER PRODUCT TO EDIT(BY NUMBER)"
    product_to_edit = gets.to_i
    product = Product.find("products", product_to_edit)
    product.display_attributes
    raw_field = ""
    puts "ENTER FIELD TO EDIT"
    raw_field = gets.chomp
    until raw_field.downcase == "done"
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
  
  # Public: #delete_product
   # Deletes a product from the locations table.
   #
   # Parameters:
   # product_to_delete      - Integer: The product ID of the location to                                          delete. 
   # verify                  _ String: If "1", confirms the deletion, otherwise, cancels.
   #
   # Returns:
   # nil.
   #
   # State changes:
   # The selected product is deleted from the database.
  
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
  
  # Public: #fetch_product
    # Fetches the product the user wants to see.
    #
    # Parameters:
    # fetch         - Integer: The selection for which product to fetch.
    #
    # Returns:
    # nil.
    #
    # State changes:
    # none
   
  def fetch_product
     product_list
     puts "TYPE THE ID OF WHAT YOU WANT TO SEE IN DETAIL"
     fetch = gets.to_i
     result = Product.find("products", fetch)
     result.display_attributes
   end   
   
   # Public: #add_category
   # Adds a new category to the categories table.
   #
   # Parameters:
   # name        - String:  name of the category to be added.
   # category    - Object:  new category object.
   # verify      - String:  verifies good input.
   # Returns:
   # nil.
   #
   # State changes:
   # New Category is added to the database.
  
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
      puts "CATEGORY SAVED TO ID ##{category.id}"
    else puts "PROCESS CANCELLED"
    end
  end  
  
  # Public: #edit_category
   # Edits an existing category entry.
   #
   # Parameters:
   # category_to_edit    - Integer: The category selection to edit. 
   # category            - Object: The category object. 
   # raw_field           - String: The existing field to be edited.
   # raw_change          - String: The new value for that field.
   # verify              _ String: Verifies good input. 
   #
   # Returns:
   # nil.
   #
   # State changes:
   # The updated object is saved to the database.
  
  
  def edit_category
    category_list
    puts "ENTER CATEGORY TO EDIT(BY NUMBER)"
    category_to_edit = gets.to_i
    category = Category.find("categories", category_to_edit)
    category.display_attributes
    raw_field = ""
    puts "ENTER FIELD TO EDIT"
    raw_field = gets.chomp
    until raw_field.downcase == "done"
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
  
  # Public: #delete_category
  # Deletes a category from the locations table.
  #
  # Parameters:
  # category_to_delete      - Integer: The category ID of the location to                                          delete. 
  # verify                  _ String: If "1", confirms the deletion, otherwise,                                   cancels.
  #
  # Returns:
  # nil.
  #
  # State changes:
  # The selected category is deleted from the database.
  
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
  
  # Public: #fetch_category
   # Fetches the category the user wants to see.
   #
   # Parameters:
   # fetch         - Integer: The selection for which category to fetch.
   #
   # Returns:
   # nil.
   #
   # State changes:
   # none
  
  def fetch_category
    category_list
    puts "TYPE THE ID OF WHAT YOU WANT TO SEE IN DETAIL"
    fetch = gets.to_i
    result = Category.find("categories", fetch)
    result.display_attributes
  end 
  
  # Public: #location_list
   # Displays the id and name of all the items in the locations table.
   #
   # Parameters:
   # locations =  
   #
   # Returns:
   # The locations table.
   #
   # State changes:
   # none  
  
  def location_list
    locations = DATABASE.execute("SELECT * FROM locations")  
    locations.each do |l|
      puts "#{l["id"]}---------#{l["name"]}"
    end
  end
  
  # Public: #category_list
   # Displays the id and name of all the items in the categories table.
   #
   # Parameters:
   # categories =  
   #
   # Returns:
   # The categories table.
   #
   # State changes:
   # none
  
  def category_list
    categories = DATABASE.execute("SELECT * FROM categories")  
    categories.each do |c|
      puts "#{c["id"]}---------#{c["name"]}"
    end
  end
  
  # Public: #product_list
  # Displays the id and name of all the items in the products table.
  #
  # Parameters:
  # products =  
  #
  # Returns:
  # The products table.
  #
  # State changes:
  # none
  
  def product_list
    products = DATABASE.execute("SELECT * FROM products")
    products.each do |p|
      puts "#{p["id"]}---------#{p["name"]}"
    end
  end
  
  # Public: #verify_edit
    # Verifies the field and attempted change are valid when editing a table.
    #
    # Parameters:
    # object                - Object:  The entry being edited
    # raw_field             - String: The field being changed(before formatting)
    # raw_change            - String  The attempted edit (before formatting)
    #
    # Returns:
    # nil.
    #
    # State changes:
    # none
  
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
  
  # Public: #enter_edit
   # Finalizes a verified edit.
   #
   # Parameters:
   # object   - Object: the entry being edited.
   # field    - String: a field that's been approved for edit.
   # change   - String or Integer: the approved edit.  
   #
   # Returns:
   # nil
   #
   # State changes:
   # Sets the object's attribute to the edited value

  def enter_edit(object, field, change)
    object.instance_variable_set(field, change)
  end
  
  # Public: #search_submenu
   # Displays the submenu for the search option.
   #
   # Parameters:
   # none
   #
   # Returns:
   # nil
   #
   # State changes:
   # none
  
  def search_submenu
    puts "TO RUN A GENERAL SEARCH PRESS 1"
    puts "TO SEARCH FOR ALL PRODUCTS IN A LOCATION PRESS 2"
    puts "TO SEARCH FOR ALL PRODUCTS IN A CATEGORY PRESS 3"
  end
  
  # Public: #general_search
    # Searches the database by product, location, or category.
    #
    # Parameters:
    # search                - String:
    # fields                -   
    # 
    #
    # Returns:
    # The products table.
    #
    # State changes:
    # none
  
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
  
  # Public: #search_by_category
    # Displays the all products in a selected category.
    #
    # Parameters:
    # search_in               - Integer:
    # results                 - Array of Product objects
    #
    # Returns:
    # The products in the selected category.
    #
    # State changes:
    # none 
     
  def search_by_category
    category_list
    puts "SELECT A CATEGORY TO SEE ALL PRODUCTS IN THAT CATEGORY(USE ID)"
    search_in = gets.to_i
    results = Product.search_where("products", "category_id", search_in)
    results.each do |r|
      r.display_attributes
    end
  end
  
  # Public: #search_by_location
    # Displays the all products in a selected location.
    #
    # Parameters:
    # search_in               - Integer:
    # results                 - Array of Product objects
    #
    # Returns:
    # The products in the selected location.
    #
    # State changes:
    # none
  
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