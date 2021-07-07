abort("The Rails environment is running in production mode!") if Rails.env.production?

user = User.create! name: "John Doe", email: "johndoe@example.com", password: "featureflow", admin: true
account = Account.create! name: "Example account", subdomain: "example", creator: user
Collaborator.create! user: user, account: account, role: "owner", joined_at: Time.zone.now

20.times do
  random_number = (1..10).to_a.sample
  joined = random_number.even? ? Time.zone.now : nil
  role = random_number.even? ? "owner" : "editor"

  collaborator = User.create! name: Faker::Name.name, email: Faker::Internet.unique.email, password: "featureflow"
  account.collaborators.create! user: collaborator, account: account, joined_at: joined, role: role
end
