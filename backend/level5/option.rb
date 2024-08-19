class Option
  attr_reader :id, :rental_id, :type

  PRICES = { 
    "gps": 500,
    "baby_seat": 200,
    "additional_insurance": 1000
  }

  def initialize(id:, rental_id:, type:)
    @id = id
    @rental_id = rental_id
    @type = type
  end

  def price
    case @type
    when "gps"
      PRICES[:gps]
    when "baby_seat"
      PRICES[:baby_seat]
    when "additional_insurance"
      PRICES[:additional_insurance]
    end
  end
end
  