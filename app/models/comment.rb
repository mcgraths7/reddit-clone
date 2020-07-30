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

  def find_author
    User.find_by(id: self.author_id)
  end
          
  def author_username
    find_author.username
  end
end