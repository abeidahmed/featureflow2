class Collaborator
  class ListComponent < ApplicationComponent
    with_collection_parameter :collaborator

    attr_reader :current_user

    def initialize(collaborator:, current_user:, **options)
      @collaborator = collaborator
      @current_user = current_user
      @options = options
    end

    private

    def current_member?
      @collaborator.user == current_user
    end

    def rolify_text
      if @collaborator.owner?
        current_member? ? "Demote yourself" : "Demote"
      else
        "Promote"
      end
    end
  end
end
