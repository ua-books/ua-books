require "rails_helper"

RSpec.describe Admin::PersonPolicy do
  let(:policy) { described_class }

  permissions :index?, :new?, :create?, :update?, :edit? do
    it "denies access to just registered user" do
      expect(policy).not_to permit(build(:user), Person.new)
    end

    it "grants access to admin" do
      expect(policy).to permit(build(:admin), Person.new)
    end
  end

  describe "scope" do
    def policy_scope(user)
      Pundit.policy_scope!(user, [:admin, Person])
    end

    let!(:person1) { create(:person) }
    let!(:person2) { create(:person) }

    it "returns nothing for just registered user" do
      expect(policy_scope(build(:user))).to be_empty
    end

    it "returns everything for admin" do
      expect(policy_scope(build(:admin))).to match [person1, person2]
    end
  end
end
