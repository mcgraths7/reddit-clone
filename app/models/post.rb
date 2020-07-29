class Post < ApplicationRecord
  validates :title, :author_id, :content, presence: true

  belongs_to :author,
             class_name: :User,
             foreign_key: :author_id,
             primary_key: :id
  belongs_to :topic
  

  def short_content
    if content.length > 50
      content[0..50] + "..."
    else
      content
    end
  end

  def author_uname
    author.username
  end
end