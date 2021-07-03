module Admin
  class ApplicationController < ::ApplicationController
    layout "admin"

    include Authenticable
    include Authorizable
  end
end
