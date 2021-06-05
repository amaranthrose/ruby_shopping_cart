class CheckoutItem
  attr_accessor :quantity, :product

  def initialize(product)
    @product = product
    @quantity = 1
  end
end
