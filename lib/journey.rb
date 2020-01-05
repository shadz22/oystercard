class Journey

  attr_reader :journey


  def initialize
    @journey = {:entry_station => nil, :exit_station => nil} 
    
  end

  def start_journey(station)
    @journey[:entry_station] = station
    
  end

  def end_journey(station)
    @journey[:exit_station] = station
  end


end