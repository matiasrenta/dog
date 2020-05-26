module PromotionsHelper

  def humanize_end_with(promotion)
    if promotion.end_with_date?
      l(promotion.to_date, format: :default)
    elsif promotion.end_with_date_or_stock?
      "#{promotion.i18n_end_with} #{l(promotion.to_date, format: :default)}"
    else
      promotion.i18n_end_with
    end
  end

end
