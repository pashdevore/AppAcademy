# == Schema Information
#
# Table name: teacher
#
#  id          :integer      not null, primary key
#  dept        :integer
#  name        :string
#  phone       :integer
#  mobile      :string
#
# Table name: dept
#
#  id          :integer      not null, primary key
#  name        :string       not null

require_relative './sqlzoo.rb'

def null_dept
  # List the teachers who have NULL for their department.
  execute(<<-SQL)
    SELECT
      name
    FROM
      teacher
    WHERE
      dept
    IS NULL
  SQL
end

def all_teachers_join
  # Use a type of JOIN that will list all teachers and their department,
  # even if the department in NULL/nil.
  execute(<<-SQL)
    SELECT
      teacher.name, dept.name
    FROM
      teacher
    FULL JOIN
      dept
    ON
      teacher.dept = dept.id
    WHERE
      teacher.name
    IS NOT
      NULL
  SQL
end

def all_depts_join
  # Use a different JOIN so that all departments are listed.
  # NB: you can avoid RIGHT OUTER JOIN (and just use LEFT) by swapping
  # the FROM and JOIN tables.
  execute(<<-SQL)
    SELECT
      teacher.name, dept.name
    FROM
      dept
    FULL JOIN
      teacher
    ON
      teacher.dept = dept.id
    WHERE
      dept.id
    IS NOT
      NULL
  SQL
end

def teachers_and_mobiles
  # Use COALESCE to print the mobile number. Use the number '07986
  # 444 2266' if no number is given. Show teacher name and mobile
  # #number or '07986 444 2266'
  execute(<<-SQL)
    SELECT
      teacher.name, COALESCE(teacher.mobile, '07986 444 2266')
    FROM
      teacher
  SQL
end

def teachers_and_depts
  # Use the COALESCE function and a LEFT JOIN to print the teacher name and
  # department name. Use the string 'None' where there is no
  # department.
  execute(<<-SQL)
    SELECT
      teacher.name, COALESCE(dept.name, 'None')
    FROM
      teacher
    LEFT JOIN
      dept
    ON
      teacher.dept = dept.id

  SQL
end

def num_teachers_and_mobiles
  # Use COUNT to show the number of teachers and the number of
  # mobile phones.
  # NB: COUNT only counts non-NULL values.
  execute(<<-SQL)
    SELECT
      COUNT(teacher.name), COUNT(teacher.mobile)
    FROM
      teacher
  SQL
end

def dept_staff_counts
  # Use COUNT and GROUP BY dept.name to show each department and
  # the number of staff. Structure your JOIN to ensure that the
  # Engineering department is listed.
  execute(<<-SQL)
    SELECT
      dept.name, COUNT(teacher.name)
    FROM
      dept
    LEFT OUTER JOIN
      teacher
    ON
      dept.id = teacher.dept
    GROUP BY
      dept.name
  SQL
end

def teachers_and_divisions
  # Use CASE to show the name of each teacher followed by 'Sci' if
  # the the teacher is in dept 1 or 2 and 'Art' otherwise.
  execute(<<-SQL)
    SELECT
      name,
      CASE (dept)
      WHEN 1
        THEN 'Sci'
      WHEN 2
        THEN 'Sci'
      ELSE 'Art'
      END
    FROM
      teacher

  SQL
end

def teachers_and_divisions_two
  # Use CASE to show the name of each teacher followed by 'Sci' if
  # the the teacher is in dept 1 or 2, 'Art' if the dept is 3, and
  # 'None' otherwise.
  execute(<<-SQL)
    SELECT
      name,
      CASE (dept)
      WHEN 1
        THEN 'Sci'
      WHEN 2
        THEN 'Sci'
      WHEN 3
        THEN 'Art'
      ELSE
        'None'
      END
    FROM
      teacher
  SQL
end
