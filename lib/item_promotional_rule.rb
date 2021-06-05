require_relative "./promotional_rule.rb"

class ItemPromotionalRule < PromotionalRule
  attr_accessor :item_code, :minimum_quantity, :new_price

  def initialize(item_code, minimum_quantity, new_price)
    @item_code = item_code
    @minimum_quantity = minimum_quantity
    @new_price = new_price
  end

  def applies?(item)
    item.product.code == item_code && item.quantity >= minimum_quantity
  end

  def promo_price(_item)
    new_price
  end
end
