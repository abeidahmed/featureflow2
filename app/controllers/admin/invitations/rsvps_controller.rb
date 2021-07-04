module Admin
  module Invitations
    class RsvpsController < InvitationsController
      def new
        skip_authorization
      end

      def edit
        skip_authorization
      end
    end
  end
end
