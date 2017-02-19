RSpec.describe EdgeRepository do
  let(:instance) {described_class.new}

  before do
    instance.clear

    instance.create(source: 'A', destination: 'B', length: 10)
    instance.create(source: 'B', destination: 'C', length: 15)
    instance.create(source: 'A', destination: 'C', length: 30)
  end

  describe 'find_by_source_and_destination' do
    subject {instance.find_by_source_and_destination('A', 'B').first}

    it '#source' do
      expect(subject.source).to eq('A')
    end

    it '#destination' do
      expect(subject.destination).to eq('B')
    end

    it '#length' do
      expect(subject.length).to eq(10)
    end
  end
end
