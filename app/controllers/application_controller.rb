class ApplicationController < ActionController::Base
  include SetCurrentAccountDetails
  include SetCurrentUserDetails
  include SessionAttributes
end
