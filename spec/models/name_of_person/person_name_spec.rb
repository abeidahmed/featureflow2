require "rails_helper"

RSpec.describe NameOfPerson::PersonName do
  describe ".full" do
    it "sets the name attributes if first name is present" do
      person = described_class.full("John Doe")

      expect(person.first).to eq("John")
      expect(person.last).to eq("Doe")
    end

    it "does not set the name attributes if first name is blank" do
      person = described_class.full("")

      expect(person&.first).to eq(nil)
      expect(person&.last).to eq(nil)
    end
  end

  describe "#initialize" do
    it "sets the instance variables" do
      person = described_class.new("John", "Doe")

      expect(person.instance_variable_get(:@first)).to eq("John")
      expect(person.instance_variable_get(:@last)).to eq("Doe")
    end

    it "raises an error if first name is blank" do
      expect { described_class.new("", "Doe") }.to raise_error(ArgumentError, "First name is required")
    end
  end

  describe "#full" do
    it "returns the full name of the person" do
      person = described_class.new("John", "Doe")

      expect(person.full).to eq("John Doe")
    end

    it "returns the first name of the person if the last name is nil" do
      person = described_class.new("John")

      expect(person.full).to eq("John")
    end
  end

  describe "#initials" do
    it "returns the initials of the persona" do
      person = described_class.new("John", "Doe")

      expect(person.initials).to eq("JD")
    end

    it "returns the first initial if the last name is nil" do
      person = described_class.new("John")

      expect(person.initials).to eq("J")
    end
  end
end
