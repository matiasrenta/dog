class BoxSearchAdapter < AutoSelect2::Select2SearchAdapter::Base
  class << self

    def limit
      50
    end

    def search_default(term, page, options)
      if options[:init].nil?
        records = default_finder(Box.order(:name), term, page: page)
        count = default_count(Box, term)
        {
            items: records.map do |tp|
              { text: tp.name, id: tp.id.to_s }
            end,
            total: count
        }
      else
        item_ids = options[:item_ids].split(' ').join(',') # le puse .split(' ').join(',') porque get_init_values los necesita separados por coma
        get_init_values(Box, item_ids)
      end
    end

  end
end
