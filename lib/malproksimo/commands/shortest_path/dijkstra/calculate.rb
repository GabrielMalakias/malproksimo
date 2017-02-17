module Commands
  module ShortestPath
    module Dijkstra
      class Calculate
        attr_accessor :graph

        def initialize
          @distances = {}
          @previouses = {}
        end

        def call(graph, source, destination)
          @graph = graph

          define_infinity_distances

          @distances[source] = 0

          vertices = graph.clone

          until vertices.empty?
            nearest_vertex  = nearest_vertex(vertices)

            break unless @distances[nearest_vertex]

            return @distances[destination] if destination and nearest_vertex == destination

            neighbors = graph.neighbors(nearest_vertex)

            neighbors.each do |vertex|
              alt = @distances[nearest_vertex] + vertices.length_between(nearest_vertex, vertex)

              if @distances[vertex].nil? or alt < @distances[vertex]
                @distances[vertex] = alt
                @previouses[vertices] = nearest_vertex
              end
            end
            vertices.delete nearest_vertex
          end


          if destination
            return nil
          else
            return @distances
          end
        end

        private

        def nearest_vertex(vertices)
          vertices.inject do |a, b|
            next b unless @distances[a]
            next a unless @distances[b]
            next a if @distances[a] < @distances[b]
            b
          end
        end

        def define_infinity_distances
          graph.each do |vertex|
            @distances[vertex] = nil
            @previouses[vertex] = nil
          end
        end
      end
    end
  end
end
