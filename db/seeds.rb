# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#
puts 'EMPTY THE MONGODB DATABASE'

Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)

puts 'SETTING UP DEFAULT USER LOGIN'

user = User.create! {[
  { :name => 'Azimuth', :email => 'azimuth@clevercode.net', :password => 'evilone', :password_confirmation => 'evilone' },
  { :name => 'Olivier', :email => 'oli@clevercode.net', :password => 'smidge', :password_confirmation => 'smidge' },
  { :name => 'Zach', :email => 'zach@clevercode.net', :password => 'smidge', :password_confirmation => 'smidge' },
  { :name => 'Andrew', :email => 'andrew@clevercode.net', :password => 'smidge', :password_confirmation => 'smidge' }
]}

user.each do |u|
  puts 'New user created: ' << u.name
end
