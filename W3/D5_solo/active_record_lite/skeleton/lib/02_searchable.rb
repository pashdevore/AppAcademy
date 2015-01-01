require_relative 'db_connection'
require_relative '01_sql_object'
require 'byebug'

module Searchable
  def where(params)
    where_line = ""
    vals = []

    params.each do |key, value|
      # byebug
      where_line += "#{key} = ? AND "
      vals << value
    end
    where_line = where_line[0..-6]

    results = DBConnection.execute(<<-SQL, *vals)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
      WHERE
        #{where_line}
    SQL

    if results.empty?
      []
    else
      return_hash = []

      if results.count > 1
        results.each_with_index do |hash,index|
          z = self.new
          results[0].each do |a|
            z.send("#{a.first}=", a.last)
          end
          return_hash << z
        end
      else
        z = self.new
        results[0].each do |a|
          z.send("#{a.first}=", a.last)
        end
        return_hash << z
      end
    end
  end
end

class SQLObject
  extend Searchable
end
