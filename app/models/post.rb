class Post < ApplicationRecord
  include Votable
  
  validates :title, :content, presence: true

  belongs_to :topic
  belongs_to :author,
             class_name: :User,
             foreign_key: :author_id,
             inverse_of: :posts
  has_many :comments, inverse_of: :post
  

  def short_content
    if content.length > 50
      content[0..50] + "..."
    else
      content
    end
  end

  def top_level_comments
    self.comments.where(parent_comment_id: nil)
  end

  def author_username
    author.username
  end

  def topic_title
    topic.title
  end

  def comments_by_parent
    comments_by_parent = Hash.new { |hash, key| hash[key] = [] }

    self.comments.includes(:author).each do |comment|
      comments_by_parent[comment.parent_comment_id] << comment
    end

    comments_by_parent
  end
end