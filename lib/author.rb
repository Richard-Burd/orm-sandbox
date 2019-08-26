class Author
  attr_accessor :id, :name

  # This method of creation is now used by <self.create(name)> instead of s.where external
  # to the actual class itself
  def initialize(name, id=nil)
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

  def save
	sql = <<-SQL 
	  INSERT INTO author (name)
	  VALUES (?) 
	SQL

	DB[:connection].execute(sql, self.name)
	@id = DB[:connection].execute("SELECT last_insert_rowid() FROM author")[0][0]
  end 

end 