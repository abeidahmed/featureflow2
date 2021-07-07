module Pageable
  extend ActiveSupport::Concern

  included do
    include Pagy::Backend

    rescue_from Pagy::OverflowError, with: :redirect_to_last_page
  end

  private

  def redirect_to_last_page(exception)
    redirect_to url_for(page: exception.pagy.last)
  end
end
