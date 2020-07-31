class Comment < ApplicationRecord
  include Votable

  validates :body, presence: true

  after_initialize :ensure_post_id!
  
  belongs_to :post, inverse_of: :comments

  belongs_to :author,
             class_name: :User,
             foreign_key: :author_id,
             inverse_of: :comments
  belongs_to :parent_comment,
             class_name: :Comment,
             foreign_key: :parent_comment_id,
             primary_key: :id,
             optional: true
  has_many :child_comments,
           class_name: :Comment,
           foreign_key: :parent_comment_id,
           primary_key: :id,
           dependent: :destroy
          
  def author_username
    author.username
  end

  private
  def ensure_post_id!
    self.post_id ||= self.parent_comment.post_id if parent_comment
  end
end