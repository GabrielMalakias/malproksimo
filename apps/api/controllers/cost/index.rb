module Api::Controllers::Cost
  class Index
    include Api::Action
    include ::AutoInject['commands.cost.calculate']

    params do
      required(:origin).filled(:str?)
      required(:destination).filled(:str?)
      required(:weight).filled(:float?, included_in?: 1...51)
    end

    def call(params)
      if params.valid?
        cost = calculate.(params)

        status 200, cost
      else
        status 412, params.error_messages
      end
    end
  end
end
