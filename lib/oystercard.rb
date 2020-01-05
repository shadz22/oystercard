require_relative 'station'
require_relative 'journey'
class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1
  attr_reader :balance, :entry_station, :exit_station, :journeys, :current_journey

  def initialize(journey = Journey.new)
    @balance = 0
    @entry_station
    @exit_station
    @journeys = []
    @current_journey = journey
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  # def in_journey?
  #   !!entry_station
  # end

  def touch_in(station)
    fail 'Insufficient amount' if balance < MINIMUM_CHARGE
    @current_journey.start_journey(station)
    store_journey
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    @current_journey.end_journey(station)
    store_journey
    @entry_station = nil
  end

 

private

def deduct(amount)
  @balance -= amount
end

def store_journey
  @journeys << @current_journey.journey
end

end
