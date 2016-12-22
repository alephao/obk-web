module Paginatable
  extend ActiveSupport::Concern

  def paginate(resource, extra_meta = {})
    {
      current_page: resource.current_page,
      next_page: resource.next_page,
      prev_page: resource.prev_page,
      total_pages: resource.total_pages,
      total_count: resource.total_count
    }.merge(extra_meta)
  end
end