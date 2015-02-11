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
  
end


    

get "/" do
  erb :homepage
end

get "/locations" do
  locations
  erb :locations
end

get "/location_details" do
  locations
end
  
  

get "/products" do
  products
  erb :products
end

get "/categories" do
  categories
  erb :categories
end