require 'action_view'
require 'action_view/helpers'

class ApplicationRecord < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  self.abstract_class = true

  def readable_timestamp(timestamp)
    time_ago_in_words(timestamp.to_time) + " ago"
  end
end
