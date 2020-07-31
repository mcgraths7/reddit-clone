require 'action_view'
require 'action_view/helpers'

class ApplicationRecord < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  self.abstract_class = true

  def readable_timestamp(timestamp)
    time_ago_in_words(timestamp.to_time) + " ago"
  end

  def self.ordered_by_hotness
    self.order(hotness: 'desc')
  end

  def self.paginate_ordered_by_hotness(page_param)
    self.ordered_by_hotness.page(page_param)
  end
end
