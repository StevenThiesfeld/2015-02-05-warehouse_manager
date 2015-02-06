DATABASE.results_as_hash = true

DATABASE.execute("CREATE TABLE IF NOT EXISTS locations (id INTEGER PRIMARY KEY,
                  name TEXT NOT NULL)")
                  
DATABASE.execute("CREATE TABLE IF NOT EXISTS categories (id INTEGER PRIMARY KEY,
                 name TEXT NOT NULL, manufacturer TEXT)")
                  
DATABASE.execute("CREATE TABLE IF NOT EXISTS products (id INTEGER PRIMARY KEY, 
                  serial_number TEXT NOT NULL, name TEXT NOT NULL, description TEXT,
                  cost INTEGER NOT NULL, quantity INTEGER NOT NULL CHECK(quantity >= 0),
                  location_id INTEGER, category_id INTEGER,
                  FOREIGN KEY(category_id) REFERENCES categories(id),
                  FOREIGN KEY(location_id) REFERENCES locations(id))")
                  
if DATABASE.execute("SELECT * FROM categories") == []              
  categories = ["Frozen", "Produce", "Canned Goods", "Beverages", "Deli", "Meat"]
  categories.each do|category|
    DATABASE.execute("INSERT INTO categories (name) VALUES ('#{category}')")
  end
end