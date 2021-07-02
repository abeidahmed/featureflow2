module Admin
  class ApplicationController < ::ApplicationController
    layout "admin"

    include Authenticable
  end
end
