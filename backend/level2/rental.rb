require 'date'
require 'pry'

class Rental
  attr_reader :id, :car_id, :start_date, :end_date, :distance

  def initialize(id:, car_id:, start_date:, end_date:, distance:)
    @id = id
    @car_id = car_id
    @start_date = start_date
    @end_date = end_date
    @distance = distance
  end

  def period
    if Date.parse(@end_date) != Date.parse(@start_date)
      Date.parse(@end_date).mjd - Date.parse(@start_date).mjd + 1
    else
      1
    end
  end
end
