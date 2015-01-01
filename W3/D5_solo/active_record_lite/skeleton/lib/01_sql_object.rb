require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject

  def self.columns
    cols = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    #TODO: columns should also be saved to attributes hash!!!
    return cols[0].map(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |sym|
      define_method(sym.to_sym) do
        #should define getter which accesses @attributes and gets value
        self.attributes[sym.to_sym]
      end

      define_method("#{sym.to_sym}=") do |value|
        #should define setter which accesses attributes and sets values there
        self.attributes[sym] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= "#{self.to_s.tableize}"
  end

  def self.all
    self.parse_all(
    DBConnection.execute(<<-SQL)
      SELECT
        #{self.table_name}.*
      FROM
        #{self.table_name}
    SQL
    )
  end

  def self.parse_all(results)
    hash = []
    self.finalize!
    results.each do |obj|
      item = self.new
      obj.each do |key, value|
        item.send("#{key}=", value)
      end
      hash << item
    end

    hash
  end

  def self.find(id)
    self.parse_all(
    DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        id = ?
    SQL
    )[0]
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      raise "unknown attribute '#{attr_name}'" unless self.class.columns.include?(attr_name.to_sym)

      self.send("#{attr_name.to_sym}=", value)
    end
  end

  def attributes
    #getter for attributes
    @attributes ||= {}
  end

  def attribute_values
    #gets attribute has vals
    result = []
    self.class.columns.map do |attr|
      result << self.send(attr.to_sym)
    end

    result
  end

  def insert
    n = self.class.columns.count

    col_names = self.class.columns.join(",")
    question_marks = (["?"] * n).join(",")

    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL

    self.send(:id=, DBConnection.last_insert_row_id)
  end

  def update
    n = self.class.columns.count

    col_names = self.class.columns.join(" = ?, ")
    col_names += " = ?"

    DBConnection.execute(<<-SQL, *attribute_values, self.send(:id))
      UPDATE
        #{self.class.table_name}
      SET
        #{col_names}
      WHERE
        id = ?
    SQL
  end

  def save
    if self.send(:id).nil?
      insert
    else
      update
    end
  end
end
