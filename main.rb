require_relative 'driver'
require 'sinatra'

get "/" do
  erb :homepage, :layout => :boilerplate
end

get "/locations" do
end

get "/products" do
end

get "/categories" do
end