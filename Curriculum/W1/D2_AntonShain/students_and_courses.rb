require 'byebug'

class Student

  attr_accessor :first_name, :last_name, :courses

  def initialize(first, last)
    @first_name = first
    @last_name = last
    @courses = []
  end

  def name
    first_name + ' ' + last_name
  end

  def enroll(course)
    if !course.students.include?(self)
      courses << course
      course.add_student(self)
    end
  end

  def course_load
    course_hash = {}
    courses.each do |course|
      if course_hash[course.department].nil?
        course_hash[course.department] = course.credits
      else
        course_hash[course.department] += course.credits
      end
    end

    course_hash
  end

end

class Course

  attr_accessor :name, :department, :credits, :students, :days, :time

  def initialize(name, dept, credits, days, time)
    @name = name
    @department = dept
    @credits = credits
    @students = []
    @days = days
    @time = time
  end

  def add_student(student)
    if student.courses.include?(self) && !self.students.include?(student)
      students << student
      student.enroll(self)
    end
  end

  def conflicts_with?(course)
    if course.time == self.time
      puts "times conflict"
      if course.days.any? { |day| self.days.include?(day) }
        puts "courses conflict"
      end
    end
  end
end
