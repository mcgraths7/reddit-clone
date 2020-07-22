class Topic < ApplicationRecord
  validates :title, :description, :moderator_id, presence: true
  validates :title, :uniqueness: true

  has_one :moderator,
          class_name: :User,
          foreign_key: :moderator_id,
          primary_key: :id
  has_many :posts,
           dependent: :destroy
end