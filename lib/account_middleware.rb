class AccountMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = ActionDispatch::Request.new(env)
    _, account_id, request_path = request.path.split("/", 3)

    if account_id =~ /\d+/
      if account = Account.find_by(id: account_id) # rubocop:disable Style/GuardClause
        Current.account = account
      else
        return [302, { "Location" => "/not_found" }, []]
      end

      request.script_name  = "/#{account_id}"
      request.path_info    = "/#{request_path}"
    end

    @app.call(request.env)
  end
end
