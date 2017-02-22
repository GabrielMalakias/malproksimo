RSpec.describe Cache::ShortestPath do
  let(:redis) {double(Redis::Client)}

  subject(:instance) { described_class.new(redis: redis) }

  describe '#find' do
    before do
      allow(redis).to receive(:hget).with('malproksimo:short_path', 'AB').and_return('10')
    end

    subject { instance.find('A', 'B') }

    it {is_expected.to eq('10')}
  end

  describe '#save' do
    before do
      allow(redis).to receive(:hset).with('malproksimo:short_path', 'AB', 10).and_return(true)
    end

    subject { instance.save('A', 'B', 10) }

    it {is_expected.to be_truthy}
  end

  describe '#find_by_prefix' do
    before do
      allow(redis).to receive(:hkeys).with('malproksimo:short_path').and_return(['AC', 'BC'])
    end

    subject { instance.find_by_prefix }

    it {is_expected.to eq(['AC', 'BC'])}
  end
end

