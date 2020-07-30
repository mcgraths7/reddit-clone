class Comment < ApplicationRecord
  belongs_to :author,
             class_name: :User,
             foreign_key: :author_id,
             primary_key: :id
  belongs_to :post
  belongs_to :parent_comment,
             class_name: :Comment,
             optional: true
  has_many :child_comments,
           class_name: :Comment,
           foreign_key: :parent_comment_id,
           dependent: :destroy
          
  def author_username
    author.username
  end
end