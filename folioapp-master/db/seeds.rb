# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.find_by_email("24525536@twitter.com")


["30 Second Tube Sketches", "Characters", "Commissioned Work", "Street Drawings"].each do |title|
	puts "hello"
	user.collections.find_or_create_by(title: title)
end

user.collections.find_by_title("Characters").works.create!(title: "Baron", image: File.open(Rails.root.join('app/assets/images/laurie/characters/baron.jpg')))