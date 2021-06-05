class CheckoutItem
  attr_accessor :quantity, :product

  def initialize(product)
    @product = product
    @quantity = 1
  end

  def price_with_promos(item_promotional_rules)
    promo_prices = []
    item_promotional_rules.map do |promo_rule|
      promo_prices << promo_rule.promo_price(self) if promo_rule.applies?(self)
    end

    if promo_prices.empty?
      product.price
    else
      promo_prices.min
    end
  end
end
