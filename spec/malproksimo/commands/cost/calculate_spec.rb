RSpec.describe Commands::Cost::Calculate do
  let(:double_calculate) {double(Commands::ShortestPath::CalculateOrRetrieve)}
  let(:params) {double(Hash)}

  describe '#call' do
    before do
      allow(params).to receive(:get).with(:origin).and_return('A')
      allow(params).to receive(:get).with(:destination).and_return('B')
      allow(params).to receive(:get).with(:weight).and_return(5)
    end

    subject { described_class.new(calculate_or_retrieve: double_calculate).call(params) }

    context 'when has a possible distance' do
      before do
        allow(double_calculate).to receive(:call).with('A', 'B').and_return(25)
      end

      it {is_expected.to eq 18.75 }
    end

    context 'when hasnt a possible distance' do
      before do
        allow(double_calculate).to receive(:call).with('A', 'B').and_return(nil)
      end

      it 'raises an ::Commands::Cost::DistanceError' do
        expect { subject }.to raise_error(::Commands::Cost::DistanceError)
      end
    end
  end
end
