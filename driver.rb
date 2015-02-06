require 'pry'
require 'sqlite3'
DATABASE = SQLite3::Database.new('warehouse_database.db')
require_relative "db_setup"
require_relative 'Location'
require_relative 'Category'
require_relative "Product"
require_relative "driver_methods"
include DriverMethods

binding.pry

menu_prompt

input = ""
until input.downcase == "quit"
  input = gets.chomp

  case input
  when "1"
    add_location
  when "2"
    #edit location
  when "3"
    delete_location
  when "4"
    add_product
  when "5"
    #edit product
  when "6"
    #delete product
  when "7"
    menu_prompt
 else
   if input.downcase == "quit"
     puts "GOOD-BYE"
   else puts "INVALID INPUT, TRY AGAIN"
   end
 end
    
end


  