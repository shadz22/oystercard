require 'oystercard'

describe Oystercard do
  let(:station) { double :station }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  it 'has an empty list of journeys' do
    expect(subject.journeys).to be_empty
  end

  describe '#top_up' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do
    expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it 'raises an error if maximum balance is exceeded' do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      expect { subject.top_up 1 }.to raise_error "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded"
    end

  end

  describe '#touch_in' do

    it 'raises an error if no min balance when touch in' do
      expect { subject.touch_in(station) }.to raise_error 'Insufficient amount'
    end

    context 'when tops up and touches in' do
      before do
        subject.top_up(2)
        subject.touch_in(station)
      end
      it 'can touch in' do
        skip
        expect(subject).to be_in_journey
      end
      it 'stores the entry station' do
        expect(subject.current_journey.journey[:entry_station]).to eq station
      end
    end
  end

  # describe '#in_journey?' do

  #   it { is_expected.to respond_to(:in_journey?) }

  #   context 'when in journey' do
  #     before do
  #       subject.top_up(2)
  #       subject.touch_in(station)
  #     end
  #   end

  #   it 'is not initially in a journey' do
  #     expect(subject).not_to be_in_journey
  #   end
  # end

  describe '#touch_out' do
    before do
      subject.top_up(2)
      subject.touch_in(station)
      subject.touch_out(exit_station)
    end

    it 'stores exit station' do
      expect(subject.current_journey.journey[:exit_station]).to eq exit_station
    end

    it 'can touch out' do
      skip
      expect(subject).not_to be_in_journey
    end

    it 'charges card at touch out' do
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_CHARGE)
    end

  end

  
  describe '#store_journey' do
  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

    it 'stores a journey' do
      subject.top_up(2)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to include journey
    end
  end

end
