# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


urls = %w(https://en.wikipedia.org/wiki/Mark_Twain
					https://en.wikipedia.org/wiki/Allan_Holdsworth
					https://en.wikipedia.org/wiki/John_McLaughlin_(musician)
          https://en.wikipedia.org/wiki/Frank_Gambale
					https://en.wikipedia.org/wiki/Paul_Gilbert
					https://en.wikipedia.org/wiki/Marty_Friedman
					https://en.wikipedia.org/wiki/Jason_Becker
					https://en.wikipedia.org/wiki/Steve_Vai)

urls.each {|url|
  name = url.split(/\//)[-1].humanize
	member = Member.create({name: name, original_url: url})
}

def get_random_member_id
  [*1..Member.count].sample
end

50.times {
  member_id = get_random_member_id
  friend_id = get_random_member_id
  Member.find(member_id).connections.create!(:member_id => friend_id)
}

