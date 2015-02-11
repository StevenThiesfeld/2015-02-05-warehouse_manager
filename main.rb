require_relative 'driver'
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
  locations
  erb :locations
end
  
get "/products" do
  products
  erb :products
end

get "/categories" do
  categories
  erb :categories
end

get "/create_location" do
  erb :create_location
end

get "/create_product" do
  erb :create_product
end

get "/create_category" do
  erb :create_category
end

get "/confirm_creation" do
  if request.referrer == "http://127.0.0.1:4567/create_location"
    @new_creation = Location.new(params) 
    @new_creation.insert("locations")
  elsif request.referrer == "http://127.0.0.1:4567/create_product"
    @new_creation = Product.new(params)
    @new_creation.insert("products")
  elsif request.referrer == "/http://127.0.0.1:4567/create_category"
    @new_creation = Category.new(params)
    @new_creation.insert("categories")
  end
  erb :confirm_creation 
end



