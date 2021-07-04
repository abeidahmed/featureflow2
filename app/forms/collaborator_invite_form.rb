class CollaboratorInviteForm
  include ActiveModel::Model

  attr_accessor :name, :email, :role

  validates :name, presence: true
  validates :email, presence: true, length: { maximum: 255 }, format: { with: User::VALID_EMAIL_REGEX }
  validates :role, presence: true, inclusion: { in: Collaborator.roles.to_a.flatten }
  validate :collaborator_uniqueness

  def self.model_name
    ActiveModel::Name.new(self, nil, "Collaborator")
  end

  def initialize(attrs = {})
    attrs[:email] = attrs[:email].to_s.strip.downcase
    super
  end

  def user
    @user ||= User.create_with(
      name: name,
      password: SecureRandom.urlsafe_base64,
    ).find_or_initialize_by(email: email)
  end

  def invite
    if valid?
      user.save
      user.collaborators.create!(role: role)
      true
    else
      false
    end
  end

  private

  def collaborator_uniqueness
    errors.add(:email, "is already registered in the account") if user.collaborator_exists?(Current.account)
  end
end
