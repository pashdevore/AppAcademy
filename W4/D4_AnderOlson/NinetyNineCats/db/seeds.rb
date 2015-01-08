# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Cat.where(
  name: 'Gizmo',
  birth_date: '2013-01-01',
  sex: 'M',
  color: 'Black',
  description: "Ned's cat"
).first_or_create!

Cat.where(
  name: 'Breakfast',
  birth_date: '2013-04-01',
  sex: 'F',
  color: 'White',
  description: "Ned's other cat"
).first_or_create!

Cat.where(
  name: 'Markov',
  birth_date: '2013-06-01',
  sex: 'F',
  color: 'Brown',
  description: "Ned's third cat"
).first_or_create!
