RSpec.describe Commands::ShortestPath::Dijkstra::Calculate do
  let(:vertices) {['A', 'B', 'C']}
  let(:edges) do
    [
      Edge.new(source: 'A', destination: 'B', length: 10),
      Edge.new(source: 'A', destination: 'C', length: 30),
      Edge.new(source: 'B', destination: 'C', length: 15)
    ]
  end
  let(:graph) {Graph.new(edges, vertices)}

  describe '#call' do
    subject {described_class.new.call(graph, 'A', 'C')}

    it {is_expected.to eq(25)}
  end
end

