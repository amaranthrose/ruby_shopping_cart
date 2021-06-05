require_relative "./promotional_rule.rb"

class TotalCartPromotionalRule < PromotionalRule
  attr_accessor :minimum_total, :percentage_discount

  def initialize(minimum_total, percentage_discount)
    @minimum_total = minimum_total
    @percentage_discount = percentage_discount
  end

  def applies?(total)
    total >= minimum_total
  end

  def promo_total(total)
    total - (total * percentage_discount/100)
  end
end
