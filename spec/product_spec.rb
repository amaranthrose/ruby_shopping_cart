require './lib/product.rb'

describe "Product" do
  it "defines code, name and price" do
    product = Product.new('001', 'Red Scarf', 9.25)

    expect(product.code).to eq '001'
    expect(product.name).to eq 'Red Scarf'
    expect(product.price).to eq 9.25
  end
end
