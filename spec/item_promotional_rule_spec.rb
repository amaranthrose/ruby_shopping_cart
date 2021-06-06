require "./lib/item_promotional_rule.rb"
require "./lib/checkout_item.rb"
require "./lib/product.rb"

describe "ItemPromotionalRule" do
  let(:promo) { ItemPromotionalRule.new(:quantity_of_single_item, {item_code: "001", minimum_quantity: 2}, :override_price, {new_price: 8.50}) }

  let(:p_001) { Product.new("001", "Red Scarf", 9.25) }
  let(:p_002) { Product.new("002", "Silver cufflinks", 45.00) }

  let(:ci_1)  { CheckoutItem.new(p_001) }
  let(:ci_2)  { CheckoutItem.new(p_002) }

  it "applies only when product code matches and quantity requirement is met" do
    # Both products have quantity 1
    expect(promo.applies?(ci_1)).to be false
    expect(promo.applies?(ci_2)).to be false

    ci_1.quantity = 2
    expect(promo.applies?(ci_1)).to be true

    ci_1.quantity = 3
    expect(promo.applies?(ci_1)).to be true

    ci_2.quantity = 2
    expect(promo.applies?(ci_2)).to be false
  end

  it "returns new price as the promo price" do
    expect(promo.promo_price(ci_1)).to eq(8.50)
  end
end
