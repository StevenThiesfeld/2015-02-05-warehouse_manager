class Category
  include DatabaseMethods
  extend ClassMethods
  attr_reader :id
  attr_accessor :name
  
  def initialize(options)
    @id = options["id"]
    @name = options["name"] 
  end
  
  def self.delete_record(id_to_remove)
    if DATABASE.execute("SELECT id FROM products WHERE location_id = #{id_to_remove}") == []
    DATABASE.execute("DELETE FROM categories WHERE #{id_to_remove} = id")
    end
  end
  
  
end#classend