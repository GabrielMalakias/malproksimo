module Commands
  module ShortestPath
    module Dijkstra
      class CalculateNeighbor
        def call(vertex, edges)
          edges.map do |edge|
            edge.destination if edge.source == vertex
          end.compact.uniq
        end
      end
    end
  end
end
