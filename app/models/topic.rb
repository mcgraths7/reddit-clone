class Topic < ApplicationRecord
  extend FriendlyId

  friendly_id :title, use: :slugged
  
  validates :title, :description, :moderator_id, presence: true
  validates :title, uniqueness: true

  has_one :moderator,
          class_name: :User,
          primary_key: :moderator_id
  has_many :posts,
           dependent: :destroy
  has_many :subscribers,
           class_name: :User,
           through: :subscriptions,
           source: :user

  before_create :set_slug

  def posts_ordered_by_karma
    posts.order(karma: 'desc')
  end

  def paginated_posts_ordered_by_karma(page_param)
    posts_ordered_by_karma.page(page_param)
  end

  def self.to_options
    Topic.all.map do |topic|
      [
        topic.title,
        topic.id
      ]
    end
  end

  private
  def set_slug
    slug_components = self.title.split(" ").map { |word| word.downcase }
    self.slug = slug_components.join("_") 
  end
end