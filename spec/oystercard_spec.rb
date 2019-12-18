require 'oystercard'

describe Oystercard do

  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
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

  describe '#in_journey?' do

    it { is_expected.to respond_to(:in_journey?) }

    it 'is not initially in a journey' do
      expect(subject).not_to be_in_journey
    end
  end

  describe '#touch_in' do

    it 'can touch in' do
      subject.top_up(2)
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it 'raises an error if no min balance when touch in' do
      expect { subject.touch_in }.to raise_error 'Insufficient amount'
    end
  end

  describe '#touch_out' do

    it 'can touch out' do
      subject.top_up(2)
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it 'charges card at touch out' do
      expect{ subject.touch_out }.to change{ subject.balance }.by(-Oystercard::MINIMUM_BALANCE)
    end

  end
end
