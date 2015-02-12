require 'pry'
require 'sqlite3'
DATABASE = SQLite3::Database.new('database/warehouse_database.db')
require_relative "database/db_setup"
require_relative "database/database_methods"
require_relative "helper_modules/model_helper"
require_relative 'models/location'
require_relative 'models/category'
require_relative "models/product"
require 'sinatra'

helpers do
  def locations
    @locations = Location.all("locations")
  end
  
  def products
    @products = Product.all("products")
  end
  
  def categories
    @categories = Category.all("categories")
  end
end#helpers_end


get "/" do
  erb :homepage
end

get "/locations" do
  if params != {}
    @locations = Location.search_where(params["table"], params["search_for"], params["user_search"])
    @search_results = "<p>Showing results for search #{params["user_search"]} in the field #{params["search_for"]}</p>"
  else
    locations
    @search_results = nil
  end
  erb :"location/locations"
end
  
get "/products" do
  if params != {}
    @products = Product.search_where(params["table"], params["search_for"], params["user_search"])
    @search_results = "<p>Showing results for search #{params["user_search"]} in the field #{params["search_for"]}.</p>"
  else
    products
    @search_results = nil
  end
  erb :"product/products"
end

get "/categories" do
  if params != {}
    @categories = Category.search_where(params["table"], params["search_for"], params["user_search"])
    @search_results = "<p>Showing results for search #{params["user_search"]} in the field #{params["search_for"]}</p>"
  else
    categories
    @search_results = nil
  end  
  erb :"category/categories"
end

get "/create_location" do
  erb :"location/create_location"
end

get "/create_product" do
  @locations = Location.all("locations")
  @categories = Category.all("categories")  
  erb :"product/create_product"
end

get "/create_category" do
  erb :"category/create_category"
end

get "/confirm_creation" do
  if request.referrer == "http://127.0.0.1:4567/create_location"
    @new_creation = Location.new(params) 
    @new_creation.insert("locations")
  elsif request.referrer == "http://127.0.0.1:4567/create_product"
    @new_creation = Product.new(params)
    @new_creation.insert("products")
  elsif request.referrer == "http://127.0.0.1:4567/create_category"
    @new_creation = Category.new(params)
    @new_creation.insert("categories")
  end
  erb :confirm_creation
end

get "/edit_location" do
  @object_to_edit = Location.find("locations", params["id"])  
  erb :"location/edit_location"
end

get "/edit_product" do
  @object_to_edit = Product.find("products", params["id"])
  @locations = Location.all("locations")
  @categories = Category.all("categories") 
  erb :"product/edit_product"
end

get "/edit_category" do
  @object_to_edit = Category.find("categories", params["id"])
  erb :"category/edit_category"
end

get "/confirm_location_edit" do 
  @edited_location = Location.find("locations", params["id"])
  @edited_location.edit_object(params)
  @edited_location.save("locations")
  erb :"location/confirm_location_edit"
end

get "/confirm_product_edit" do  
  @edited_product = Product.find("products", params["id"])
  @edited_product.edit_object(params)
  @edited_product.save("products")
  erb :"product/confirm_product_edit"
end

get "/confirm_category_edit" do  
  @edited_category = Category.find("categories", params["id"])
  @edited_category.edit_object(params)
  @edited_category.save("categories")
  erb :"category/confirm_category_edit"
end
  
get "/delete_product" do
  @product_to_delete = Product.find("products", params["id"])
  erb :"product/delete_product"
end

get "/confirm_delete_product" do
  Product.delete_record("products", params["id"])
  products
  erb :"product/products"
end

before "/delete_location" do
  @products = Product.search_where("products", "location_id", params["id"])
  if @products != []
    request.path_info = "/error"
  end
end

get "/delete_location" do
  @location_to_delete = Location.find("locations", params["id"])
  erb :"location/delete_location"
end

get "/confirm_delete_location" do
  Location.delete_record(params["id"])
  locations
  erb :"location/locations"
end

get "/error" do
  erb :error
end

before "/delete_category" do
  @products = Product.search_where("products", "category_id", params["id"])
  if @products != []
    request.path_info = "/error"
  end
end

get "/delete_category" do
  @category_to_delete = Category.find("categories", params["id"])
  erb :"category/delete_category"
end

get "/confirm_delete_category" do
  Category.delete_record(params["id"])
  categories
  erb :"category/categories"
end