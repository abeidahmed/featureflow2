module Authorizable
  extend ActiveSupport::Concern

  included do
    include Pundit
    # rubocop:disable Rails/LexicallyScopedActionFilter
    after_action :verify_authorized, except: :index
    after_action :verify_policy_scoped, only: :index
    # rubocop:enable Rails/LexicallyScopedActionFilter
  end
end
