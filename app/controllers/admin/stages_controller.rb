module Admin
  class StagesController < ApplicationController
    def index
      skip_policy_scope
    end

    def create
      authorize Current.account, policy_class: StagePolicy
      @stage = Stage.new(stage_params)

      if @stage.save
        redirect_to roadmap_path
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
