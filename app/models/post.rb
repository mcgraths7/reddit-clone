class Post < ApplicationRecord
  validates :title, :author_id, presence: true

  belongs_to :author,
             class_name: :User,
             foreign_key: :author_id,
             primary_key: :id
  belongs_to :topic
end