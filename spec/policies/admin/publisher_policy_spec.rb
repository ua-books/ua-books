require "rails_helper"

RSpec.describe Admin::PublisherPolicy do
  let(:policy) { described_class }

  permissions :index?, :new?, :create?, :update?, :edit? do
    it "denies access to just registered user" do
      expect(policy).not_to permit(build(:user), Publisher.new)
    end

    it "grants access to admin" do
      expect(policy).to permit(build(:admin), Publisher.new)
    end
  end

  describe "scope" do
    def policy_scope(user)
      Pundit.policy_scope!(user, [:admin, Publisher])
    end

    let!(:publisher1) { create(:publisher) }
    let!(:publisher2) { create(:publisher) }

    it "returns nothing for just registered user" do
      expect(policy_scope(build(:user))).to be_empty
    end

    it "returns everything for admin" do
      expect(policy_scope(build(:admin))).to match [publisher1, publisher2]
    end
  end
end
