class Author
  attr_accessor :id, :name

  # This method of creation is now used by <self.create(name)> instead of s.where external
  # to the actual class itself
  def initialize(name=nil, id=nil)
    @name = name
  end

  def self.create(name)
  	# Here the method calls on the <initialize(name, id=nil)> above
  	author = Author.new(name)
  	author.save
  	author 
  end 

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS author (
        id INTEGER PRIMARY KEY,
        name TEXT
      )
    SQL
    DB[:connection].execute(sql)
  end

  # This method will convert what the database gives us into a Ruby object.
  def self.new_from_db(row)
  	new_author = self.new     # self.new is the same as running Author.new
  	new_author.id = row[0]
  	new_author.name = row[1]
  	new_author                # return the newly created instance
  end 

  def save
	sql = <<-SQL 
	  INSERT INTO author (name)
	  VALUES (?) 
	SQL

	DB[:connection].execute(sql, self.name)
	@id = DB[:connection].execute("SELECT last_insert_rowid() FROM author")[0][0]
  end 


  def self.find_by_name(name)
    sql = <<-SQL
      SELECT *
      FROM author
      WHERE name = ?
      LIMIT 1
    SQL
 
    DB[:connection].execute(sql, name).map do |row|
      self.new_from_db(row)
    end.first
  end

end 

