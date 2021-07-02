require "rails_helper"

RSpec.describe AccountMiddleware do
  before do
    Current.account = nil
  end

  it "loads the correct account if the id is present in the URL" do
    account = create(:account)
    account_path = "/#{account.id}"
    path = "/posts"
    full_path = account_path + path

    app = ->(env) { [200, env, "app"] }
    middleware = described_class.new(app)
    response = Rack::MockRequest.new(middleware).get(full_path, "REQUEST_PATH" => full_path)

    expect(Current.account).to eq(account)
    expect(response["SCRIPT_NAME"]).to eq(account_path)
    expect(response["PATH_INFO"]).to eq(path)
  end

  it "redirects to root_path if it fails to load the account" do
    account_path = "/12345"
    path = "/posts"
    full_path = account_path + path

    app = ->(env) { [200, env, "app"] }
    middleware = described_class.new(app)
    response = Rack::MockRequest.new(middleware).get(full_path, "REQUEST_PATH" => full_path)

    expect(response.headers["Location"]).to eq("/")
    expect(Current.account).to eq(nil)
    expect(response["SCRIPT_NAME"]).to eq(nil)
    expect(response["PATH_INFO"]).to eq(nil)
  end
end
