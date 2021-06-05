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
      total += (item.quantity * item_price_with_promos(item))
    end

    cart_promotional_rules.each do |promo_rule|
      total = promo_rule.promo_price(total) if promo_rule.applies?(total)
    end

    total
  end

  def item_price_with_promos(item)
    price = item.product.price

    item_promotional_rules.each do |promo_rule|
      price = promo_rule.promo_price(item) if promo_rule.applies?(item)
    end

    price
  end
end
