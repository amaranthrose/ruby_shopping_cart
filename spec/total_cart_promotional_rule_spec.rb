require './lib/total_cart_promotional_rule.rb'

describe "TotalCartPromotionalRule" do
  let(:promo) { TotalCartPromotionalRule.new(60.0, 10) }

  it "applies when given total is equal or bigger than minimum" do
    expect(promo.applies?(65.0)).to be true
    expect(promo.applies?(60.0)).to be true
    expect(promo.applies?(59.99)).to be false
    expect(promo.applies?(0.00)).to be false
  end

  it "applies percantage_discount to the total" do
    expect(promo.promo_total(100.0)).to eq(90)
  end
end
