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

  describe "when there are mutliple promo rules of same type" do
    it "applies only the most beneficial item rule applicable" do
      item_promo_1 = ItemPromotionalRule.new("001", 5, 1.00)
      item_promo_2 = ItemPromotionalRule.new("001", 4, 3.00)
      item_promo_3 = ItemPromotionalRule.new("001", 2, 8.50)
      item_promo_4 = ItemPromotionalRule.new("002", 2, 11.00)

      promotional_rules = {item: [item_promo_1, item_promo_2, item_promo_3, item_promo_4]}

      co = Checkout.new(promotional_rules)
      co.scan(p_001)
      co.scan(p_002)
      co.scan(p_001)
      co.scan(p_001)
      co.scan(p_001)

      price = co.total

      # with item_promo_3 applied it would be 79.00
      expect(price).to eq(57.00)
    end

    it "applies only the most beneficial cart rule applicable" do
      cart_promo_1 = CartPromotionalRule.new(100.0, 20)
      cart_promo_2 = CartPromotionalRule.new(60.0, 10)
      cart_promo_3 = CartPromotionalRule.new(150.0, 25)

      promotional_rules = {cart: [cart_promo_1, cart_promo_2, cart_promo_3]}

      co = Checkout.new(promotional_rules)
      co.scan(p_003)
      co.scan(p_002)
      co.scan(p_002)

      price = co.total

      # only the cart_promo_1 should get applied
      expect(price).to eq(87.96)
    end
  end
end
