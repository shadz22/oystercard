require 'journey'

describe Journey do
  let(:station) { double :station, zone: 1 } 
   
  it { is_expected .to respond_to(:start_journey).with(1).argument }
  
  it 'sets entry station' do
    subject.start_journey(station)
    expect(subject.journey[:entry_station]).to eq station
  end

  it 'sets exit station' do
    subject.end_journey(station)
    expect(subject.journey[:exit_station]).to eq station
  end

end