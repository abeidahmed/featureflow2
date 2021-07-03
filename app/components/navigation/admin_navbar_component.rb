module Navigation
  class AdminNavbarComponent < ApplicationComponent
    def initialize(current_user:)
      @current_user = current_user
    end
  end
end
