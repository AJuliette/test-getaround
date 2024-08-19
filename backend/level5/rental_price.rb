class RentalPrice
    attr_reader :rental_id, :period, :options_prices

  def initialize(rental_id:, price_per_day:, period:, price_per_km:, distance:, options_prices:)
    @rental_id = rental_id
    @price_per_day = price_per_day
    @period = period
    @price_per_km = price_per_km
    @distance = distance
    @options_prices = options_prices
  end

  def compute
    (price_per_period + price_per_distance + total_prices_of_options).to_i
  end

  def price_per_period
    (1..@period).to_a.map do |day|
      @price_per_day * (1 - price_decreases(day))
    end.inject(:+)
  end

  def price_per_distance
    @price_per_km * @distance
  end

  def price_decreases(day)
    case day
    when 1
      0
    when (2..4)
      0.1
    when (5..10)
      0.3
    else
      0.5
    end
  end

  def total_prices_of_options
    if @options_prices.any?
      @options_prices.map do |option_price|
        option_price * period
      end.inject(:+)
    else
      0
    end
  end
end
