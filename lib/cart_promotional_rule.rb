require_relative "./promotional_rule.rb"

class CartPromotionalRule < PromotionalRule
  attr_accessor :minimum_total, :percentage_discount

  def initialize(minimum_total, percentage_discount)
    @minimum_total = minimum_total
    @percentage_discount = percentage_discount
  end

  def applies?(total)
    total >= minimum_total
  end

  def promo_price(total)
    (total - (total * percentage_discount/100)).round(2)
  end
end
