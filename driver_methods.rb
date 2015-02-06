module DriverMethods

  def add_location
    puts "ENTER LOCATION NAME"
    name = gets.chomp
    location = Location.new(name: name)
    puts "YOU HAVE ENTERED #{location.name}"
    puts "IF THIS IS CORRECT PRESS 1"
    puts "IF THIS IS INCORRECT PRESS ANYTHING OTHER THAN 1 TO CANCEL CREATION"
    verify = gets.chomp
    if verify == "1"
      location.save_record
      puts "LOCATION SAVED ID ##{location.id}"
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
    
  
  def menu_prompt
    puts "WELCOME TO THE WAREHOUSE MANAGEMENT SUITE"
    puts "-"*60
    puts "TO CREATE A NEW LOCATION: TYPE 1"
    puts "-"*60
    puts "TO EDIT A LOCATION\'S DATA: TYPE 2"
    puts "-"*60
    puts "TO DELETE A LOCATION: TYPE 3"
    puts "-"*60
    puts "TO CREATE A NEW PRODUCT: TYPE 4"
    puts "-"*60
    puts "TO EDIT A PRODUCT\'S DATA: TYPE 5"
    puts "-"*60
    puts "TO DELETE A PRODUCT: TYPE 6"
    puts "-"*60
    puts "TO SEE THIS MENU AGAIN TYPE 7"
    puts "-"*60
    puts "TYPE QUIT TO EXIT THE PROGRAM"
  end
  
  def add_product
    puts "ENTER PRODUCT SERIAL NUMBER"
    serial_number = gets.to_i
    puts "ENTER PRODUCT NAME"
    name = gets.chomp
    puts "ENTER PRODUCT DESCRIPTION"
    description = gets.chomp
    puts "ENTER PRODUCT COST"
    cost = gets.to_i
    puts "ENTER PRODUCT QUANTITY"
    quantity = gets.to_i
    puts "ENTER LOCATION ID"
    location_id = gets.to_i
    puts "ENTER CATEGORY ID"
    category_id = gets.to_i
    new_product = Product.new({serial_number: serial_number, name: name,
       description: description, cost: cost, quantity: quantity,
        location_id: location_id, category_id: category_id })
    
    puts "PRESS 1 TO SAVE PRODUCT"
    puts "PRESS ANYTHING OTHER THAN 1 TO CANCEL CREATION"
    verify = gets.chomp
    if verify == "1"
      new_product.save_record
      puts "PRODUCT SAVED, PRODUCT ID IS #{new_product.id}"
    else puts "PROCESS CANCELLED"
    end
  end
  
  
end