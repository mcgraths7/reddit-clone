module PaginatedRecord
  def ordered_by_karma
    self.order(karma: 'desc')
  end

  def paginate_ordered_by_karma(page_param)
    self.ordered_by_karma.page(page_param)
  end
end