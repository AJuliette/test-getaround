class RentalPrice
    attr_reader :rental_id

  def initialize(rental_id:, price_per_day:, period:, price_per_km:, distance:)
    @rental_id = rental_id
    @price_per_day = price_per_day
    @period = period
    @price_per_km = price_per_km
    @distance = distance
  end

  def compute
    @price_per_day * @period + @price_per_km * @distance
  end
end
