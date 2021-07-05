class User
  module Tenant
    def collaborator_exists?(account)
      collaborators.exists?(account_id: account)
    end

    def invite_accepted?(account)
      find_collaborator(account)&.joined_at?
    end

    def invite_pending?(account)
      find_collaborator(account) && find_collaborator(account).joined_at.nil?
    end

    def account_owner?(account)
      find_collaborator(account)&.owner?
    end

    def find_collaborator(account)
      collaborators.find_by(account_id: account)
    end
  end
end
