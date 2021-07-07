class ApplicationController < ActionController::Base
  include SetCurrentAccountDetails
  include SetCurrentUserDetails
  include SessionAttributes
  include Pageable

  add_flash_types :success
end
