require './lib/checkout_item.rb'

class Checkout
  attr_accessor :scanned_items

  def initialize
    @scanned_items = {}
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

    total
  end
end
