require "./lib/product.rb"
require "./lib/checkout.rb"
require "./lib/cart_promotional_rule.rb"
require "./lib/item_promotional_rule.rb"

describe "Checkout" do
  let(:p_001) { Product.new("001", "Red Scarf", 9.25) }
  let(:p_002) { Product.new("002", "Silver cufflinks", 45.00) }
  let(:p_003) { Product.new("003", "Silk dress", 19.95) }

  let(:total_cart_promo)  { CartPromotionalRule.new(60.0, 10) }
  let(:single_item_promo) { ItemPromotionalRule.new("001", 2, 8.50) }
  let(:promotional_rules) { {cart: [total_cart_promo], item: [single_item_promo]} }

  it "allows scanning the products and calculates total price" do
    co = Checkout.new()
    co.scan(p_001)
    co.scan(p_002)
    co.scan(p_001)
    price = co.total

    expect(price).to eq(63.5)
  end

  it "applies total cart promo rules" do
    co = Checkout.new(promotional_rules)
    co.scan(p_001)
    co.scan(p_002)
    co.scan(p_003)
    price = co.total

    expect(price).to eq(66.78)
  end

  it "applies item promo rules" do
    co = Checkout.new(promotional_rules)
    co.scan(p_001)
    co.scan(p_003)
    co.scan(p_001)
    price = co.total

    expect(price).to eq(36.95)
  end

  it "applies both promo rules" do
    co = Checkout.new(promotional_rules)
    co.scan(p_001)
    co.scan(p_002)
    co.scan(p_001)
    co.scan(p_003)
    price = co.total

    expect(price).to eq(73.76)
  end
end
