puts "Generating users..."
10.times do
  u = User.new
  u.username = Faker::Internet.username
  u.password = Faker::Internet.password(min_length: 8)
  unless u.save
    next
  end
end
u = User.new
u.username = 'joebizness'
u.password = 'P4nth3r$'
u.save

puts "Users generated!"

user_count = User.all.count
puts "Generating topics..."
25.times do
  t = Topic.new
  possible_titles = [Faker::Hacker.noun, Faker::Hacker.adjective, Faker::Hacker.verb, Faker::Hacker.ingverb]
  t.title = possible_titles[rand(4)]
  t.description = Faker::Hacker.say_something_smart
  t.moderator_id = 1 + rand(user_count)
  unless t.save
    next
  end
end
puts "Topics generated!"
u.subscribe_to(1)
u.subscribe_to(2)
u.subscribe_to(3)
u.subscribe_to(4)
u.subscribe_to(5)
u.subscribe_to(6)

topic_count = Topic.all.count
puts "Generating posts..."
500.times do 
  post = Post.new
  post.title = Faker::Lorem.sentence(word_count: 3)
  post.content = Faker::Lorem.paragraph
  post.author_id = 1 + rand(user_count)
  post.topic_id = 1 + rand(topic_count)
  unless post.save
    next
  end
end
puts "Posts generated!"

puts "Generating slugs..."
Topic.all.each do |topic|
  words = topic.title.split(" ")
  slugs = words.map do |word|
    word.downcase
  end
  slug = slugs.join("_")
  topic.slug = slug
  topic.save
end
puts "Slugs generated!"

post_count = Post.all.count

puts "Generating comments..."
1000.times do
  author_id = 1 + rand(user_count)
  post_id = 1 + rand(post_count)
  comment = Comment.new(author_id: author_id, post_id: post_id, content: Faker::Lorem.sentence)
  unless comment.save
    next
  end
end
puts "Comments generated!"

comment_count = Comment.all.count

puts "Generating child comments"
c = Comment.find_by(id: 1)
1000.times do
  author_id = 1 + rand(user_count)
  post_id = 1 + rand(post_count)
  parent_comment_id = 1 + rand(comment_count)
  child = Comment.new(content: "child comment", author_id: author_id, post_id: post_id, parent_comment_id: parent_comment_id)
  unless child.save
    next
  end
end
puts "Child comments generated!"
Vote.destroy_all
puts "Generating post votes"
4000.times do 
  user_id = 1 + rand(user_count)
  post_id = 1 + rand(post_count)
  post = Post.find(post_id)
  value = 1
  user = User.find(user_id)
  post.votes << Vote.create(user_id: user_id, value: value)
  post.update(karma: post.karma + 1)
  user.update(post_karma: user.post_karma + 1)
end
puts "Post votes generated"

puts "Generating comment votes"
4000.times do 
  comment = Comment.find(1 + rand(comment_count))
  user = User.find(1 + rand(user_count))
  comment.votes << Vote.create(user_id: user.id, value: 1)
  comment.update(karma: comment.karma + 1)
  user.update(comment_karma: user.comment_karma + 1)
end
