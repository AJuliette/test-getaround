class ActionFactory
    attr_reader :who, :type
  
    def initialize(who:, type:, rental_price:, rental_commission:)
      @who = who
      @type = type
      @rental_price = rental_price
      @rental_commission = rental_commission
    end

    def compute
      { 
				"who": @who,
				"type": @type,
				"amount": amount,
			}
		end

    def amount
      case [@who, @type]
      when ["driver", "debit"]
        @rental_price.compute
      when ["owner", "credit"]
        @rental_price.compute - @rental_commission.compute
      when ["insurance", "credit"]
        @rental_commission.insurance_fee
      when ["assistance", "credit"]
        @rental_commission.assistance_fee
      when ["drivy", "credit"]
        @rental_commission.drivy_fee
      end
    end
  end
  