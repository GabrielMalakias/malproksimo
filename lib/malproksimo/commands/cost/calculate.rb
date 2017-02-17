module Commands
  module Cost
    class Calculate
      include ::AutoInject['commands.shortest_path.calculate_or_retrieve']

      FIXED_TAX = 0.15

      def call(params)
        distance = calculate_or_retrieve.(params.get(:origin), params.get(:destination))

        params.get(:weight) * FIXED_TAX * distance.to_f
      end
    end
  end
end
