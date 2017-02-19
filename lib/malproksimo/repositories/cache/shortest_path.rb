module Cache
  class ShortestPath
    include ::AutoInject['clients.redis']

    def find(origin, destination)
      redis.hget(prefix, cache_key(origin, destination))
    end

    def save(origin, destination, distance)
      redis.hset(prefix, cache_key(origin, destination), distance)
    end

    def find_by_prefix
      redis.hkeys(prefix)
    end

    private

    def prefix
      Cache::SHORTEST_PATH_PREFIX
    end

    def cache_key(origin, destination)
      origin + destination
    end
  end
end
