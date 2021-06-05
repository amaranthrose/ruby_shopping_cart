require './lib/checkout_item.rb'

class Checkout
  attr_accessor :scanned_items, :promotional_rules

  def initialize(promo_rules = [])
    @scanned_items = {}
    @promotional_rules = promo_rules
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
      total += (item.quantity * item.product.price)
    end

    promotional_rules.each do |promo_rule|
      total = promo_rule.promo_total(total) if promo_rule.applies?(total)
    end

    total
  end
end
