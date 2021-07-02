module Admin
  module Authenticable
    extend ActiveSupport::Concern

    included do
      before_action :authenticate_user
    end

    private

    def authenticate_user
      redirect_to new_session_path(script_name: nil) unless Current.user
    end
  end
end
