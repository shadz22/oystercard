require 'station'

describe Station do
  
  let(:name) {"Old Street"}
  let(:zone) {1}
  let(:subject) {Station.new(name, zone)}

    it 'knows its name' do
      expect(subject.name).to eq "Old Street"
    end

    it 'knows its zone' do
      expect(subject.zone).to eq 1
    end
end