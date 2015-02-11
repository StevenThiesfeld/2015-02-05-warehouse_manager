require 'pry'
require 'sqlite3'
DATABASE = SQLite3::Database.new('warehouse_database.db')
require_relative "db_setup"
require_relative "database_methods"
require_relative 'location'
require_relative 'category'
require_relative "product"
require_relative "driver_methods"
include DriverMethods


# input = ""
# until input.downcase == "quit"
#   menu_prompt
#
#   puts "ENTER MENU SELECTION"
#   input = gets.chomp
#
#   case input
#   when "1"
#     submenu("LOCATION")
#     sub_input = gets.chomp
#     case sub_input
#     when "1"
#       add_location
#     when "2"
#       edit_location
#     when "3"
#       delete_location
#     when "4"
#       fetch_location
#     else puts "RETURNING TO MAIN MENU"
#     end
#
#   when "2"
#     submenu("PRODUCT")
#     sub_input = gets.chomp
#     case sub_input
#     when "1"
#       add_product
#     when "2"
#       edit_product
#     when "3"
#       delete_product
#     when "4"
#       fetch_product
#     else puts "RETURNING TO MAIN MENU"
#     end
#
#   when "3"
#     submenu("CATEGORY")
#     sub_input = gets.chomp
#     case sub_input
#     when "1"
#       add_category
#     when "2"
#       edit_category
#     when "3"
#       delete_category
#     when "4"
#       fetch_category
#     else puts "RETURNING TO MAIN MENU"
#     end
#
#   when "4"
#     search_submenu
#     sub_input = gets.chomp
#     case sub_input
#     when "1"
#       general_search
#     when "2"
#       search_by_location
#     when "3"
#       search_by_category
#     else puts "RETURNING TO MAIN MENU"
#     end
#
#  else
#    if input.downcase == "quit"
#      puts "GOOD-BYE"
#    else puts "INVALID INPUT, TRY AGAIN"
#    end
#  end
# end