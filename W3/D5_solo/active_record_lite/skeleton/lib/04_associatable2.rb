require_relative '03_associatable'
require 'byebug'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    # ex: home, human, house
    options = belongs_to(through_name)

    define_method(name) do
      (DBConnection.execute(<<-SQL, self.class.id)
        SELECT
          "#{source_name}s".*
        FROM
          "#{through_name}s"
        JOIN
          "#{source_name}s" ON "#{through_name}s"."#{source_name}_id" = "#{source_id}s".id
        WHERE
          "#{through_name}".id = ?
      SQL
      ).first
    end
  end
end
