RSpec.describe Commands::Graph::Load do
  let(:repository) {double(EdgeRepository)}
  let(:edge) {Edge.new(id: 1, source: 'A', destination: 'B', length: 10)}
  let(:expected_graph) {Graph.new([edge], ['A', 'B'])}

  before do
    allow(repository).to receive(:all).and_return([edge])
  end

  describe '#call' do

    subject {described_class.new(repository: repository).call}

    it 'returns edges' do
      expect(subject.edges).to eq([edge])
    end

    it 'returns vertices' do
      expect(subject.vertices).to eq(['A', 'B'])
    end
  end
end
