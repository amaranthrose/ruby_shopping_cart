require './lib/product.rb'
require './lib/checkout.rb'
require './lib/total_cart_promotional_rule.rb'

describe "Checkout" do
  let(:p_001) { Product.new('001', 'Red Scarf', 9.25) }
  let(:p_002) { Product.new('002', 'Silver cufflinks', 45.00) }
  let(:p_003) { Product.new('003', 'Silk dress', 19.95) }

  let(:total_cart_promo) { TotalCartPromotionalRule.new(60.0, 10) }

  it "allows scanning the products and calculates total price" do
    co = Checkout.new()
    co.scan(p_001)
    co.scan(p_002)
    co.scan(p_001)
    price = co.total

    expect(price).to eq(63.5)
  end

  it "applies total cart promo rules" do
    co = Checkout.new([total_cart_promo])
    co.scan(p_001)
    co.scan(p_002)
    co.scan(p_003)
    price = co.total

    expect(price).to eq(66.78)
  end
end
