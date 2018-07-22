require "rails_helper"

RSpec.describe Admin::PublisherPolicy do
  let(:policy) { described_class }

  permissions :index? do
    it "denies access to just registered user" do
      expect(policy).not_to permit(build(:user), Publisher.new)
    end

    it "denies access to publisher" do
      expect(policy).not_to permit(build(:publisher_user), Publisher.new)
    end

    it "grants access to admin" do
      expect(policy).to permit(build(:admin), Publisher.new)
    end
  end

  permissions :new?, :create? do
    it "grants access to just registered user" do
      expect(policy).to permit(build(:user), Publisher.new)
    end

    it "denies access to publisher" do
      expect(policy).not_to permit(build(:publisher_user), Publisher.new)
    end

    it "grants access to admin" do
      expect(policy).to permit(build(:admin), Publisher.new)
    end
  end

  permissions :edit?, :update? do
    let(:publisher) { create(:publisher) }

    it "denies access to just registered user" do
      expect(policy).to_not permit(build(:user), publisher)
    end

    it "grants access to the same publisher" do
      expect(policy).to permit(build(:publisher_user, publisher: publisher), publisher)
    end

    it "denies access to other publisher" do
      expect(policy).not_to permit(build(:publisher_user), publisher)
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

    it "returns self for publisher" do
      user = build(:publisher_user, publisher: publisher1)
      expect(policy_scope(user)).to eq [publisher1]
    end
  end
end
