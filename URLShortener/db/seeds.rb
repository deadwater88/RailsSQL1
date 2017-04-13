# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 100.times do |i|
#   user = User.create!(email: "dog#{i}@gmail.com")
#   short_url = ShortenedUrl.generate_short_url(user, 'www.google.com')
#   short_url_object = ShortenedUrl.find_by(short_url: short_url)
#   Visit.record_visit!(user, short_url_object)
# end

# TagTopic.create(topic: "search")
# TagTopic.create(topic: "information")
# TagTopic.create(topic: "e-mail")
# TagTopic.create(topic: "maps")
url1 = ShortenedUrl.find_by(id: 1)
url2 = ShortenedUrl.find_by(id: 2)
url3 = ShortenedUrl.find_by(id: 3)
# Tagging.create(short_url_id: 1, topic_id: 1)
# Tagging.create(short_url_id: 1, topic_id: 2)
# Tagging.create(short_url_id: 2, topic_id: 1)
Tagging.create(short_url_id: 3, topic_id: 1)

user = User.first

100.times do
  Visit.record_visit!(user, url2)
end

50.times do
  Visit.record_visit!(user, url1)
end

15.times do
  Visit.record_visit!(user, url3)
end
