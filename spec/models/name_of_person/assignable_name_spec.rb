require "rails_helper"

RSpec.describe NameOfPerson::AssignableName do
  before do
    person_class = Class.new(Struct.new(:first_name, :last_name)) do
      include NameOfPerson::AssignableName

      def self.full(full_name)
        first, last = full_name.to_s.squish.split(/\s/, 2)
        new(first, last) if first.present?
      end

      def last
        last_name
      end
    end

    stub_const("NameOfPerson::PersonName", person_class)
  end

  let(:person) { NameOfPerson::PersonName.new("John", "Doe") }

  describe "#name" do
    it "returns the name of the person" do
      expect(NameOfPerson::PersonName.new("John", "Doe")).to eq(person.name)
    end
  end

  describe "#name=" do
    it "sets the name of the person" do
      person.name = "Jane Doe"

      expect(NameOfPerson::PersonName.new("Jane", "Doe")).to eq(person.name)
    end
  end
end
