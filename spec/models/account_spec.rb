require "rails_helper"

RSpec.describe Account, type: :model do
  subject(:account) { build(:account) }

  describe "associations" do
    it { is_expected.to belong_to(:creator).class_name("User").optional }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_length_of(:name).is_at_most(255) }

    it { is_expected.to validate_presence_of(:subdomain) }

    it { is_expected.to validate_uniqueness_of(:subdomain).case_insensitive }

    it { is_expected.to validate_exclusion_of(:subdomain).in_array(%w[analyzer blog snbn resources assets cdn static status * www feedback app]) }

    it { is_expected.to define_enum_for(:status).with_values(active: "active", inactive: "inactive").backed_by_column_of_type(:string) }

    it { is_expected.to allow_value("example.hello.com", "").for(:cname) }

    it { is_expected.not_to allow_value("example. hello. com").for(:cname) }
  end

  describe "callbacks" do
    it "downcases cname" do
      account = create(:account, cname: "HELLO.example.Com")

      expect(account.cname).to eq("hello.example.com")
    end

    it "strips https, http from cname" do
      account = create(:account, cname: "https://hello.example.com")

      expect(account.cname).to eq("hello.example.com")

      account = create(:account, cname: "http://hello.example.com")

      expect(account.cname).to eq("hello.example.com")
    end
  end
end
