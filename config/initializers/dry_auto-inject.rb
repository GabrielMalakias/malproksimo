module Malproksimo
  class Container
    extend Dry::Container::Mixin

    register('edges.repository') do
      EdgeRepository.new
    end

    register('commands.edges.create_or_update_and_enqueue') do
      Commands::Edges::CreateOrUpdateAndEnqueue.new
    end

    register('commands.cost.calculate') do
      Commands::Cost::Calculate.new
    end

    register('commands.shortest_path.dijkstra') do
      Commands::ShortestPath::Dijkstra::Calculate.new
    end

    register('commands.graph.load') do
      Commands::Graph::Load.new
    end

    register('clients.redis') do
      Redis.new(url: ENV.fetch('CACHE_URL'))
    end

    register('cache.shortest_path') do
      Cache::ShortestPath.new
    end

    register('commands.shortest_path.calculate_or_retrieve') do
      Commands::ShortestPath::CalculateOrRetrieve.new
    end
  end
end

AutoInject = Dry::AutoInject(Malproksimo::Container)
