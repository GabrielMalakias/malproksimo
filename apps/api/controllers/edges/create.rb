module Api::Controllers::Edges
  class Create
    include Api::Action
    include ::AutoInject['commands.edges.create_or_update_and_enqueue']

    params do
      required(:source).filled(:str?)
      required(:destination).filled(:str?)
      required(:length).filled(:int?, included_in?: 1...100001)
    end

    def call(params)
      if params.valid?
        create_or_update_and_enqueue.(params)

        status 200, "Created or Updated"
      else
        status 412, params.error_messages
      end
    end
  end
end
