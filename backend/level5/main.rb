require 'json'
require_relative 'car'
require_relative 'rental'
require_relative 'rental_price'
require_relative 'rental_commission'
require_relative 'option'
require_relative 'action_factory'
require_relative 'initialize_objects_from_json'
require_relative 'initialize_rental_prices'

class Main
  def self.perform
    data = get_data
    objects = InitializeObjectsFromJson.new(data:)
    cars = objects.get_cars
    options = objects.get_options
    rentals = objects.get_rentals
    rental_prices = InitializeRentalPrices.new(rentals:, cars:, rental_options: options).compute
    output = calculate_output(rental_prices:, rental_options: options)
    write_output(output:)
  end

  private

  def self.get_data
    file = File.read('data/input.json')
    JSON.parse(file)
  end

  def self.calculate_output(rental_prices:, rental_options:)
    rentals_with_actions = rental_prices.each_with_object([]) do |rental_price, array|
      rental_commission = RentalCommission.new(rental_id: rental_price.rental_id,
                                              price: rental_price.compute,
                                              price_of_options: rental_price.total_prices_of_options,
                                              period: rental_price.period,
                                              additional_insurance: rental_options.select { |option| option.rental_id == rental_price.rental_id && option.type == "additional_insurance" }.any?)

      array << { "id": rental_price.rental_id,
                "options": rental_options.select{ |option| option.rental_id == rental_price.rental_id && option.type }.map { |option| option.type },
                "actions": [
                    ActionFactory.new(rental_id: rental_price.rental_id, who: "driver", type: "debit", "rental_price": rental_price, "rental_commission": rental_commission).compute,
                    ActionFactory.new(rental_id: rental_price.rental_id, who: "owner", type: "credit", "rental_price": rental_price, "rental_commission": rental_commission).compute,
                    ActionFactory.new(rental_id: rental_price.rental_id, who: "insurance", type: "credit", "rental_price": rental_price, "rental_commission": rental_commission).compute,
                    ActionFactory.new(rental_id: rental_price.rental_id, who: "assistance", type: "credit", "rental_price": rental_price, "rental_commission": rental_commission).compute,  
                    ActionFactory.new(rental_id: rental_price.rental_id, who: "drivy", type: "credit", "rental_price": rental_price, "rental_commission": rental_commission).compute
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
