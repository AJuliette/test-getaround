class RentalCommission
	def initialize(rental_id:, price:, period:, price_of_options:, additional_insurance:)
		@price = price
    @period = period
    @price_of_options = price_of_options
    @additional_insurance = additional_insurance
	end

	def compute
    ((@price - @price_of_options) * 0.3).to_i
  end

  def insurance_fee
    (compute / 2).to_i
  end

  def assistance_fee
    (@period * 100).to_i
  end

  def drivy_fee
    (compute + additional_insurance_fee - insurance_fee - assistance_fee).to_i
  end

  def additional_insurance_fee
    if @additional_insurance
      ::Option::PRICES[:additional_insurance] * @period
    else
      0
    end
  end
end