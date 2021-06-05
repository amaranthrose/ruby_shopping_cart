require_relative "./checkout_item.rb"

class Checkout
  attr_accessor :scanned_items, :cart_promotional_rules, :item_promotional_rules

  def initialize(promo_rules = {})
    @scanned_items = {}
    @cart_promotional_rules = promo_rules[:cart] || []
    @item_promotional_rules = promo_rules[:item] || []
  end

  def scan(item)
    if @scanned_items[item.code]
      @scanned_items[item.code].quantity += 1
    else
      @scanned_items[item.code] = CheckoutItem.new(item)
    end
  end

  def total
    total = 0.0

    @scanned_items.each do |_item_code, item|
      total += (item.quantity * item.price_with_promos(item_promotional_rules))
    end

    total_with_promos(total)
  end

  def total_with_promos(total)
    promo_prices = []

    cart_promotional_rules.map do |promo_rule|
      promo_prices << promo_rule.promo_price(total) if promo_rule.applies?(total)
    end

    if promo_prices.empty?
      total
    else
      promo_prices.min
    end
  end
end
