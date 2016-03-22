# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if Homeland::Node.count == 0
  root_names = %w(Support Bug Dev Meta Feature Releases Faq HowTo)
  root_names.each do |name|
    Homeland::Node.create(name: name, description: name)
  end
end
