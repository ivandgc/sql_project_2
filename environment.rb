require 'sqlite3'
require 'pry'
require 'csv'

DB = {:conn => SQLite3::Database.new("./db/got.db")}
DB[:conn].execute("DROP TABLE IF EXISTS battles")
DB[:conn].execute("DROP TABLE IF EXISTS character_deaths")
DB[:conn].execute("DROP TABLE IF EXISTS character_predictions")

require_relative './queries.rb'
require_relative './schema.rb'
require_relative './execution.rb'
