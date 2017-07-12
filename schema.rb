class Game_Of_Thrones

  attr_accessor :column_labels, :datatypes, :filename

  def initialize(filename)
    @column_labels =[]
    @datatypes = []
    @filename = filename
  end

  def get_columns
    self.column_labels = CSV.foreach(self.filename).first.collect do |t|
      t.include?(" ") ? t.downcase.gsub!(" ", "_") : t.downcase
    end.collect {|t| t.include?(".") ? t.gsub!(".", "") : t }
  end

  def table_name
    filename[2..-5]
  end

  def values
    first_row = 0
    CSV.foreach(self.filename).map do |row|
      if first_row == 0
        first_row = 1
        nil
      else
        row
      end
    end.compact
  end

  def get_datatypes
    self.values.each { |r| self.datatypes = r.map do |value|
      ((Float(value) !=nil rescue false)? "INTEGER" : "TEXT") if ! value.nil?
    end }
  end

  def attributes
      Hash[*self.column_labels.zip(self.datatypes).flatten]
  end

  def create_table
    create_table_string = self.attributes.map do |attribute, datatype|
      "#{attribute} #{datatype}"
    end.join(", ")
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS #{self.table_name}
      (id INTEGER PRIMARY KEY,
        #{create_table_string})
    SQL
    DB[:conn].execute(sql)
  end

  def insert
    self.values.each {|row| self.into_table(row)}
  end

  def into_table(row_values)
    question_marks = ("?"*self.column_labels.length).chars.join(", ")
    sql = <<-SQL
      INSERT INTO #{self.table_name} (#{self.column_labels.join(", ")}) VALUES
        (#{question_marks})
    SQL
    DB[:conn].execute(sql, *row_values)
  end

end
