# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

["SlimKitty", "Jada", "T-boz", "Connor", "Sylvester", "Pusheen"].each do |name|
  Cat.create(name: name, birth_date: "2015/01/20", color: "white", sex: "F", description: "The cutest cat in the entire database")
end 
