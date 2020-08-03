module PaginatedRecord
  def self.ordered_by_hotness
    self.order(hotness: 'desc')
  end

  def self.paginate_ordered_by_hotness(page_param)
    self.ordered_by_hotness.page(page_param)
  end
end