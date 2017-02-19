RSpec.describe Commands::ShortestPath::CalculateOrRetrieve do
  let(:load_graph) {double(Commands::Graph::Load)}
  let(:calculate_dijkstra) {double(Commands::ShortestPath::Dijkstra)}
  let(:cache_shortest_path) {double(Cache::ShortestPath)}
  let(:edge) {Edge.new(id: 1, source: 'A', destination: 'B', length: 10)}
  let(:graph) {Graph.new([edge], ['A', 'B'])}

  describe '#call' do
     subject { described_class.new(load_graph: load_graph, calculate_dijkstra: calculate_dijkstra, cache_shortest_path: cache_shortest_path).call('A', 'B') }

    context 'when found in cache' do
      before do
        expect(cache_shortest_path).to receive(:find).with('A', 'B').and_return('25')
      end

      it {is_expected.to eq(25)}
    end

    context 'when doesnt found in cache' do
      before do
        expect(cache_shortest_path).to receive(:find).with('A', 'B').and_return(nil)
        expect(load_graph).to receive(:call).and_return(graph)
        expect(calculate_dijkstra).to receive(:call).with(graph, 'A', 'B').and_return(25)
        expect(cache_shortest_path).to receive(:save).with('A', 'B', 25)
      end

      it {is_expected.to eq(25)}
    end
  end
end
