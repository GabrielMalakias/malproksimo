module Workers
  #
  # Worker to recalculate distances when a vertex is added ou changed
  #
  # @api public
  #
  class DistanceCalculator
    include Sidekiq::Worker
    include ::AutoInject[
      load_graph: 'commands.graph.load',
      shortest_path_cache: 'cache.shortest_path',
      calculate_dijkstra: 'commands.shortest_path.dijkstra'
    ]

    LOGGER_TAG = 'WORKER'.freeze

    # Recalculate all distances between source and destinations already searched
    #
    # @api public
    #
    def perform
      graph = load_graph.()

      calculated_costs = costs_keys_already_calculated

      calculated_costs.each do |key|
        source = key.first
        destination = key.last

        distance = calculate_dijkstra.(graph, source, destination)

        log_and_save(source, destination, distance)
      end
    end

    private

    # Log and save in cache the recalculated distance
    #
    # @api private
    #
    def log_and_save(source, destination, distance)
      Hanami::Logger.new(LOGGER_TAG).info("Recalculating source: #{source} destination: #{destination} to distance: #{distance}")
      shortest_path_cache.save(source, destination, distance)
    end

    #
    # Retrive a list containing source and destinations into an array
    #
    # @api private
    #
    def costs_keys_already_calculated
      shortest_path_cache.find_by_prefix.map do |key|
        key.scan(/\w/)
      end
    end
  end
end
