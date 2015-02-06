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
  
  
end