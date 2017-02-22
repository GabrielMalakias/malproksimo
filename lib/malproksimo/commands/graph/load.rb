module Commands
  module Graph
    class Load
      include ::AutoInject['edges.repository']

      def call
        edges = repository.all

        ::Graph.new(edges, vertices(edges))
      end

      private

      def vertices(edges)
        edges.inject([]) do |vertices, edge|
          vertices << edge.source
          vertices << edge.destination
        end.uniq
      end
    end
  end
end
