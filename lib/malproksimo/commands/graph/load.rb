module Commands
  module Graph
    class Load
      def call
        edges = repository.all

        graph = ::Graph.new
        graph.edges = edges

        vertices(edges).map do |vertex|
          graph.push vertex
        end

        graph
      end

      private

      def repository
        EdgeRepository.new
      end

      def vertices(edges)
        edges.inject([]) do |vertices, edge|
          vertices << edge.source
          vertices << edge.destination
        end.uniq
      end
    end
  end
end
