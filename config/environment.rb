require 'bundler/setup'
Bundler.require

require_all 'lib'



# This will create the new database in the workspace
DB = {
  :connection => SQLite3::Database.new("db/development.sqlite")
}

# These are no longer needed with the new <self.create(name)> method in author.rb
=begin
a = Author.new("Alan")
b = Author.new("Brian")

Author.create_table
a.save 
b.save
=end 

a = Author.create("Alex")
a.save

# To start, wer will create an empty array for <self.new_from_db(row)>
row = [1, "Dimetry"]

Author.new_from_db(row)
Author.find_by_name("Alex")

binding.pry 
