RSpec.describe Commands::Cost::Calculate do
  let(:double_calculate) {double(Commands::ShortestPath::CalculateOrRetrieve)}
  let(:params) do
    {origin: 'A', destination: 'B', weight: 5}
  end

  subject { described_class.new(calculate_or_retrieve: double_calculate).call(params) }

  before do
    allow(double_calculate).to receive(:call).with('A', 'B').and_return(25)
  end

  it {is_expected.to eq 18.75 }
end
