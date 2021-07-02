class ApplicationController < ActionController::Base
  include SetCurrentUserDetails
  include SessionAttributes
end
