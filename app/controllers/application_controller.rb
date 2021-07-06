class ApplicationController < ActionController::Base
  include SetCurrentAccountDetails
  include SetCurrentUserDetails
  include SessionAttributes

  add_flash_types :success
end
