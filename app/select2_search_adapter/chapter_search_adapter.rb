class ChapterSearchAdapter < AutoSelect2::Select2SearchAdapter::Base
  class << self

    def limit
      10
    end

    def search_default(term, page, options)
      if options[:init].nil?
        chapters = default_finder(Chapter.order(:name), term, page: page)
        count = default_count(Chapter, term)
        {
            items: chapters.map do |tp|
              { text: tp.name, id: tp.id.to_s }
            end,
            total: count
        }
      else
        item_ids = options[:item_ids].split(' ').join(',') # le puse .split(' ').join(',') porque get_init_values los necesita separados por coma
        get_init_values(Chapter, item_ids)
      end
    end

  end
end
