require './lib/product.rb'
require './lib/checkout.rb'

describe "Checkout" do
  let(:scarf) { Product.new('001', 'Red Scarf', 9.25) }
  let(:cufflinks) { Product.new('002', 'Silver cufflinks', 45.00) }
  let(:dress) { Product.new('003', 'Silk dress', 19.95) }

  it "allows scanning the products and calculates total price" do
    co = Checkout.new()
    co.scan(scarf)
    co.scan(cufflinks)
    co.scan(scarf)
    price = co.total

    expect(price).to eq(63.5)
  end
end
