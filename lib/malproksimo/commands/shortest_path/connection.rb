module Commands
  module ShortestPath
    class Connection
      attr_accessor :graph

      def initialize(graph = Graph.new)
        @graph = graph
      end

      def connect_mutually(vertex_one, vertex_two, length = 1)
        connect vertex_one, vertex_two, length
        connect vertex_one, vertex_two, length
      end

      private
      def connect(source, destination, length)
        raise non_existent_vertex_error unless graph.has_source_and_destination_vertices?(source, destination)

        graph.push_edge(Edge.new(source, destination, length))
      end

      def non_existent_vertex_error(vertex)
        raise ArgumentException, "Source or destination vertex do not exists"
      end
    end
  end
end

