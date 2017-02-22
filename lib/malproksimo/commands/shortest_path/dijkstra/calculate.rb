module Commands
  module ShortestPath
    module Dijkstra
      class Calculate
        include ::AutoInject[
          'commands.shortest_path.dijkstra.calculate_neighbors'
        ]

        def call(graph, source, destination)
          vertices = graph.vertices.clone

          initialize_and_define_infinity_distances(graph.vertices)
          @distances[source] = 0

          until vertices.empty?
            nearest_vertex  = calculate_nearest_vertex(vertices)

            break unless @distances[nearest_vertex]

            return @distances[destination] if destination and nearest_vertex == destination

            neighbors = calculate_neighbors.(nearest_vertex, graph.edges)

            neighbors.each do |vertex|
              alt = @distances[nearest_vertex] + graph.length_between(nearest_vertex, vertex)

              if @distances[vertex].nil? or alt < @distances[vertex]
                @distances[vertex] = alt
                @previouses[vertices] = nearest_vertex
              end
            end
            vertices.delete nearest_vertex
          end

          @distances unless destination
        end

        private

        def initialize_and_define_infinity_distances(vertices)
          @distances = {}
          @previouses = {}

          vertices.each do |vertex|
            @distances[vertex] = nil
            @previouses[vertex] = nil
          end
        end

        def calculate_nearest_vertex(vertices)
          vertices.inject do |a, b|
            next b unless @distances[a]
            next a unless @distances[b]
            next a if @distances[a] < @distances[b]
            b
          end
        end
      end
    end
  end
end
