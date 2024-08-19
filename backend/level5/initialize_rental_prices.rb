class InitializeRentalPrices

	def initialize(rentals:, cars:, rental_options:)
		@rentals = rentals
    @cars = cars
    @rental_options = rental_options
	end

  def compute
    @rentals.map do |rental|
      car = @cars.select { |car| car.id == rental.car_id }.pop
      options = @rental_options.select { | option| option.rental_id == rental.id }
      RentalPrice.new(rental_id: rental.id,
                price_per_day: car.price_per_day,
                period: rental.period,
                price_per_km: car.price_per_km,
                distance: rental.distance,
                options_prices: options.map { |option| option.price }
      )
    end
  end
end
