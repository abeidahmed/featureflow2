module Admin
  class StagesController < ApplicationController
    def index
      @stages = policy_scope(Stage)
    end

    def create
      authorize Current.account, policy_class: StagePolicy
      @stage = Stage.new(stage_params)

      if @stage.save
        respond_to { |format| format.turbo_stream }
      else
        render json: { errors: @stage.errors }, status: :unprocessable_entity
      end
    end

    private

    def stage_params
      params.require(:stage).permit(:name, :color)
    end
  end
end
