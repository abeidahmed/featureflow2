module SetCurrentUserDetails
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user
  end

  private

  def set_current_user
    Current.user = User.find_by(auth_token: cookies.signed[:auth_token])
  end
end
