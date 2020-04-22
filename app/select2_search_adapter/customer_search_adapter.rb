class CustomerSearchAdapter < AutoSelect2::Select2SearchAdapter::Base
  class << self

    def limit
      5
    end

    def search_default(term, page, options)
      if options[:init].nil?
        customers = default_finder(Customer.order(:name), term, page: page)
        count = default_count(Customer, term)
        {
            items: customers.map do |tc|
              { text: tc.name, id: tc.id.to_s }
            end,
            total: count
        }
      else
        get_init_values(Customer, options[:item_ids])
      end
    end

  end
end
