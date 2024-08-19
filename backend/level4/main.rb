require 'json'
require_relative 'car'
require_relative 'rental'
require_relative 'rental_price'
require_relative 'rental_commission'
require_relative 'action_factory'
require_relative 'initialize_objects_from_json'
require_relative 'initialize_rental_prices'

class Main
  def self.perform
    data = get_data
    objects = InitializeObjectsFromJson.new(data:)
    cars = objects.get_cars
    rentals = objects.get_rentals
    rental_prices = InitializeRentalPrices.new(rentals:, cars:).compute
    output = calculate_output(rental_prices:)
    write_output(output:)
  end

  private

  def self.get_data
    file = File.read('data/input.json')
    JSON.parse(file)
  end

  def self.calculate_output(rental_prices:)
    rentals_with_actions = rental_prices.each_with_object([]) do |rental_price, array|
      rental_commission = RentalCommission.new(rental_id: rental_price.rental_id, price: rental_price.compute, period: rental_price.period)
      array << { "id": rental_price.rental_id,
                "actions": [
                    ActionFactory.new(who: "driver", type: "debit", "rental_price": rental_price, "rental_commission": rental_commission).compute,
                    ActionFactory.new(who: "owner", type: "credit", "rental_price": rental_price, "rental_commission": rental_commission).compute,
                    ActionFactory.new(who: "insurance", type: "credit", "rental_price": rental_price, "rental_commission": rental_commission).compute,
                    ActionFactory.new(who: "assistance", type: "credit", "rental_price": rental_price, "rental_commission": rental_commission).compute,  
                    ActionFactory.new(who: "drivy", type: "credit", "rental_price": rental_price, "rental_commission": rental_commission).compute
                  ]
      }
    end

    { "rentals" => rentals_with_actions }
  end

  def self.write_output(output:)
    File.open('data/output.json', 'w') do |f|
      f.write(output.to_json)
    end
  end
end

Main.perform
