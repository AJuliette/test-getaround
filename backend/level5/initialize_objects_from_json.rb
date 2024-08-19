class InitializeObjectsFromJson

	def initialize(data:)
		@data = data
	end

	def get_cars
    @data["cars"].map do |car_hash|
      Car.new(id: car_hash["id"],
              price_per_day: car_hash["price_per_day"],
              price_per_km: car_hash["price_per_km"]
      )
    end
  end

  def get_rentals
    @data["rentals"].map do |rental_hash|
      rental = Rental.new(id: rental_hash["id"],
                car_id: rental_hash["car_id"],
                start_date: rental_hash["start_date"],
                distance: rental_hash["distance"],
                end_date: rental_hash["end_date"]
      )
    end
  end

  def get_options
    @data["options"].map do |option_hash|
        Option.new(id: option_hash["id"],
                rental_id: option_hash["rental_id"],
                type: option_hash["type"]
        )
    end
  end
end