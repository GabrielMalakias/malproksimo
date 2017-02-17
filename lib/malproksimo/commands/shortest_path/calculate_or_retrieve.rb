module Commands
  module ShortestPath
    class CalculateOrRetrieve
      include ::AutoInject[
        load_graph: 'commands.graph.load',
        dijkstra_calculate: 'commands.shortest_path.dijkstra',
        cache_shortest_path: 'cache.shortest_path'
      ]

      def call(source, destination)
        distance = cache_shortest_path.find(source, destination)

        return distance if distance && (!distance.empty?)
        recalculate_and_save(source, destination)
      end

      private

      def recalculate_and_save(source, destination)
        distance = dijkstra_calculate.(load_graph.(), source, destination)
        cache_shortest_path.save(source, destination, distance)
        distance
      end
    end
  end
end
