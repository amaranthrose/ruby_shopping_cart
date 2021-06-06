class CartPromotionalRule
  attr_accessor :requirement_type, :requirements, :result_type, :results

  REQUIREMENT_TYPES = [:total_cart_value]
  RESULT_TYPES =      [:percentage]
  REQUIREMENTS_KEYS =
    {
      total_cart_value: [:minimum_total]
    }
  RESULTS_KEYS =
    {
      percentage: [:percentage_discount]
    }

  def initialize(requirement_type, requirements, result_type, results)
    @requirement_type = requirement_type
    @requirements = requirements
    @result_type = result_type
    @results = results
  end

  def applies?(total)
    case requirement_type
    when :total_cart_value
      total >= requirements[:minimum_total]
    else
      raise "Unknown requirement type #{requirement_type}"
    end
  end

  def promo_price(total)
    case result_type
    when :percentage
      (total - (total * results[:percentage_discount]/100)).round(2)
    else
      raise "Unknown result type #{result_type}"
    end
  end
end
