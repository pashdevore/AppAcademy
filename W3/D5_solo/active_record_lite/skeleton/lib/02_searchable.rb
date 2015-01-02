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
        *
      FROM
        #{table_name}
      WHERE
        #{where_line}
    SQL

    parse_all(results)
  end
end

class SQLObject
  extend Searchable
end
