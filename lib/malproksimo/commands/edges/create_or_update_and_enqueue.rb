module Commands
  module Edges
    class CreateOrUpdateAndEnqueue
      include ::AutoInject['edges.repository']

      def call(params)
        result = repository.find_by_source_and_destination(params.get(:source), params.get(:destination))

        if result.first
          repository.update(result.first.id, params)
        else
          repository.create(params)
        end

        Workers::DistanceCalculator.perform_async
      end
    end
  end
end
