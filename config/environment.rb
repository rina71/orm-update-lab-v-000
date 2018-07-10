require 'sqlite3'
require_relative '../lib/student'
require_relative 'pry'

DB = {:conn => SQLite3::Database.new("db/students.db")}
