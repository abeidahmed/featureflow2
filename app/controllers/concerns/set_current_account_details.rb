module SetCurrentAccountDetails
  extend ActiveSupport::Concern

  included do
    set_current_tenant_through_filter

    before_action :set_tenant
  end

  private

  def set_tenant
    set_current_tenant(Current.account)
  end
end
