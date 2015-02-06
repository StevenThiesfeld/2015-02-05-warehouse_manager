require 'pry'
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
    #methods
  when "3"
    #methods
  when "4"
    #methodsmethodsmethods
  when "5"
    #methodsmethodsmethods
  when "6"
    #methodsmethodsmethods
  when "7"
    menu_prompt
 else
   if input.downcase == "quit"
     puts "GOOD-BYE"
   else puts "INVALID INPUT, TRY AGAIN"
   end
 end
    
end


  