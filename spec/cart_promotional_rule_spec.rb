require "./lib/cart_promotional_rule.rb"

describe "CartPromotionalRule" do
  let(:promo) { CartPromotionalRule.new(:total_cart_value, {minimum_total: 60.0}, :percentage, {percentage_discount: 10}) }

  it "applies when given total is equal or bigger than minimum" do
    expect(promo.applies?(65.0)).to be true
    expect(promo.applies?(60.0)).to be true
    expect(promo.applies?(59.99)).to be false
    expect(promo.applies?(0.00)).to be false
  end

  it "applies percentage_discount to the total" do
    expect(promo.promo_price(100.0)).to eq(90)
  end
end
