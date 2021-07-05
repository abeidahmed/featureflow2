module Admin
  module Settings
    class DomainsController < ApplicationController
      def edit
        skip_authorization
      end
    end
  end
end
