module Commands
  module Cost
    DistanceError = Class.new(StandardError)

    class Calculate
      include ::AutoInject['commands.shortest_path.calculate_or_retrieve']

      FIXED_TAX = 0.15

      def call(params)
        distance = calculate_or_retrieve.(params.get(:origin), params.get(:destination))

        raise_invalid_distance if distance.nil?

        params.get(:weight) * FIXED_TAX * distance
      end

      private

      def raise_invalid_distance
        raise DistanceError, 'Invalid distance, please try to add more edges to calculate a possible route'
      end
    end
  end
end
