# puts "Generating users..."
# 25.times do
#   u = User.new
#   u.username = Faker::Internet.username
#   u.password = Faker::Internet.password(min_length: 8)
#   unless u.save
#     next
#   end
# end
# puts "Users generated!"

# user_count = User.all.count
# puts "Generating topics..."
# 100.times do
#   t = Topic.new
#   possible_titles = [Faker::Hacker.noun, Faker::Hacker.adjective, Faker::Hacker.verb, Faker::Hacker.ingverb]
#   t.title = possible_titles[rand(4)]
#   t.description = Faker::Hacker.say_something_smart
#   t.moderator_id = 1 + rand(user_count)
#   unless t.save
#     next
#   end
# end
# puts "Topics generated!"

# topic_count = Topic.all.count
# puts "Generating posts..."
# 1000.times do 
#   post = Post.new
#   post.title = Faker::Lorem.sentence(word_count: 3)
#   post.content = Faker::Lorem.paragraph
#   post.author_id = 1 + rand(user_count)
#   post.topic_id = 1 + rand(topic_count)
#   unless post.save
#     next
#   end
# end
# puts "Posts generated!"

# puts "Generating slugs..."
# Topic.all.each do |topic|
#   words = topic.title.split(" ")
#   slugs = words.map do |word|
#     word.downcase
#   end
#   slug = slugs.join("_")
#   topic.slug = slug
#   topic.save
# end
# puts "Slugs generated!"
# u = User.new
# u.username = 'joebizness'
# u.password = 'P4nth3r$'
# u.save

u = User.last
u.subscribe_to(1)
u.subscribe_to(2)
u.subscribe_to(3)
u.subscribe_to(4)
u.subscribe_to(5)
u.subscribe_to(6)