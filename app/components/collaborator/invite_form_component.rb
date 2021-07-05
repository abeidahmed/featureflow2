class Collaborator
  class InviteFormComponent < ApplicationComponent
    attr_reader :current_user

    def initialize(current_user:, account:, **options)
      @current_user = current_user
      @account = account
      @options = options
    end

    def collaborator
      current_user.find_collaborator(@account)
    end

    def render?
      policy(collaborator).create?
    end
  end
end
