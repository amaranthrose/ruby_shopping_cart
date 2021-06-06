class ItemPromotionalRule
  attr_accessor :requirement_type, :requirements, :result_type, :results

  REQUIREMENT_TYPES = [:quantity_of_single_item]
  RESULT_TYPES =      [:override_price]
  REQUIREMENTS_KEYS =
    {
      quantity_of_single_item: [:item_code, :minimum_quantity]
    }
  RESULTS_KEYS =
    {
      override_price: [:new_price]
    }

  def initialize(requirement_type, requirements, result_type, results)
    @requirement_type = requirement_type
    @requirements = requirements
    @result_type = result_type
    @results = results
  end

  def applies?(item)
    case requirement_type
    when :quantity_of_single_item
      item.product.code == requirements[:item_code] && item.quantity >= requirements[:minimum_quantity]
    else
      raise "Unknown requirement type #{requirement_type}"
    end
  end

  def promo_price(price)
    case result_type
    when :override_price
      results[:new_price]
    else
      raise "Unknown result type #{result_type}"
    end
  end
end
