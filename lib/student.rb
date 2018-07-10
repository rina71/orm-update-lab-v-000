require_relative "../config/environment.rb"

class Student
  attr_accessor :id, :name, :grade

  def initialize(id = nil, name, grade)
    @id = id
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE students (
        id INTEGER
        name TEXT
        grade TEXT
      )

    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
      sql = <<-SQL
      DROP TABLE students
      SQL

    DB[:conn].execute(sql)
  end

  def save
    if self.id
      self.update
    else
      sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    end

  end

  def self.create(name, grade)
    a = Student.new(name,grade)
    a.save
  end

  def self.new_from_db(row)
    sql = <<-SQL
    SELECT *
    FROM students
    SQL
    DB[:conn].excute(sql).map do |row|
      Students.new(row[0],row[1],row[2])    
    end

  end


end
