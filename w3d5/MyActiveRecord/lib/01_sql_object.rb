require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    @columns ||= DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL

    @columns.first.map(&:to_sym)
  end

  def self.finalize!
    columns.each do |col_name|
      define_method "#{col_name}" do
        attributes[col_name]
      end

      define_method "#{col_name}=" do |val|
        attributes[col_name] = val
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.to_s.downcase.pluralize
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
      SELECT
        #{self.table_name}.*
      FROM
        #{self.table_name}
    SQL
    self.parse_all(results)
  end

  def self.parse_all(results)
    results.map { |result| self.new(result) }
  end

  def self.find(id)
    self.all.find{ |obj| obj.id == id }
  end

  def initialize(params = {})
    params.each do |attr_name, val|
      unless self.class.columns.include?(attr_name.to_sym)
        raise "unknown attribute '#{attr_name.to_s}'"
      else
        send("#{attr_name}=", val)
      end
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.attributes.values
  end

  def insert
    col_names = self.class.columns.drop(1).join(",")
    q_marks = ("?," * (self.class.columns.length - 2)) + "?"

    DBConnection.execute(<<-SQL, attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{q_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    id = attribute_values.take(1)
    set_line = self.class.columns.drop(1).map{|attr_name| "#{attr_name} = ?"}.join(",")

    DBConnection.execute(<<-SQL, attribute_values.drop(1), id)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_line}
      WHERE
        id = ?
    SQL
  end

  def save
    id ? self.update : self.insert
  end
end
