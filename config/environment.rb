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

binding.pry 
