class ThingCategorySearchAdapter < AutoSelect2::Select2SearchAdapter::Base
  class << self

    def limit
      50
    end

    def search_default(term, page, options)
      if options[:init].nil?
        thing_categories = default_finder(ThingCategory.order(:name), term, page: page)
        count = default_count(ThingCategory, term)
        {
            items: thing_categories.map do |tc|
              { text: tc.name, id: tc.id.to_s }
            end,
            total: count
        }
      else
        get_init_values(ThingCategory, options[:item_ids])
      end
    end

  end
end
