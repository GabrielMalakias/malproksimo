RSpec.describe Commands::Edges::CreateOrUpdateAndEnqueue do
  let(:repository) {double(EdgeRepository)}
  let(:params) {double}
  let(:edge) {Edge.new(id: 1, source: 'A', destination: 'B', length: 10)}

  before do
    allow(params).to receive(:get).with(:source).and_return('A')
    allow(params).to receive(:get).with(:destination).and_return('B')
  end

  describe '#call' do

    subject {described_class.new(repository: repository).call(params)}

    context 'when found an edge' do
      before do
        allow(repository).to receive(:find_by_source_and_destination).with('A', 'B').and_return([edge])
      end

      it 'updates the found edge' do
        expect(repository).to receive(:update).with(1, params).and_return(true)
        subject
      end
    end

    context 'when not found an edge' do
      before do
        allow(repository).to receive(:find_by_source_and_destination).with('A', 'B').and_return([])
      end

      it 'creates a new edge' do
        expect(repository).to receive(:create).with(params).and_return(true)
        subject
      end
    end
  end
end

