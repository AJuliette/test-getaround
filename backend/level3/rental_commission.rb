class RentalCommission
	def initialize(rental_id:, price:, period:)
		@price = price
    @period = period
	end

	def compute
    (@price * 0.3).to_i
  end

  def insurance_fee
    (compute / 2).to_i
  end

  def assistance_fee
    (@period * 100).to_i
  end

  def drivy_fee
    (compute - insurance_fee - assistance_fee).to_i
  end
end
