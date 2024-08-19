class InitializeRentalPrices

	def initialize(rentals:, cars:)
		@rentals = rentals
    @cars = cars
	end

  def compute
    @rentals.map do |rental|
      car = @cars.select { |car| car.id == rental.car_id }.pop
      RentalPrice.new(rental_id: rental.id,
                price_per_day: car.price_per_day,
                period: rental.period,
                price_per_km: car.price_per_km,
                distance: rental.distance
      )
    end
  end
end
