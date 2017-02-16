module Commands
  module ShortestPath
    class Graph < Array
      attr_reader :edges

      def initialize
        @edges = []
      end

      def push_edge(edge)
        @edges.push(edge)
      end

      def has_source_and_destination_vertices?(source, destination)
        self.include?(source) && self.include?(destination)
      end

      def neighbors(vertex)
        n = []

        @edges.each do |edge|
          n.push(edge.dst) if edge.src == vertex
        end

        n.uniq
      end

      def length_between(src, dst)
        @edges.each do |edge|
          return edge.length if edge.src == src and edge.dst == dst
        end
        nil
      end
    end
  end
end

