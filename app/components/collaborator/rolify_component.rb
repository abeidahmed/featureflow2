class Collaborator
  class RolifyComponent < ApplicationComponent
    def initialize(collaborator:, current_user:)
      @collaborator = collaborator
      @current_user = current_user
    end

    private

    def current_member?
      @current_user == @collaborator.user
    end

    def box_title
      if @collaborator.owner?
        "Demote #{current_member? ? 'yourself' : @collaborator.name}?"
      else
        "Promote #{@collaborator.name}?"
      end
    end

    def button_text
      if @collaborator.owner?
        current_member? ? "Demote myself" : "Demote"
      else
        "Promote"
      end
    end

    def button_class
      @collaborator.owner? ? "btn--danger" : "btn--primary"
    end
  end
end
