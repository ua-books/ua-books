require "rails_helper"

RSpec.describe Admin::BookPolicy do
  let(:policy) { described_class }

  permissions :index?, :new?, :create?, :update?, :edit? do
    it "denies access to just registered user" do
      expect(policy).not_to permit(build(:user), Book.new)
    end

    it "grants access to admin" do
      expect(policy).to permit(build(:admin), Book.new)
    end
  end

  describe "scope" do
    def policy_scope(user)
      Pundit.policy_scope!(user, [:admin, Book])
    end

    let(:publisher) { create(:publisher) }
    let!(:book1) { create(:book, publisher: publisher) }
    let!(:book2) { create(:book) }

    it "returns nothing for just registered user" do
      expect(policy_scope(build(:user))).to be_empty
    end

    it "returns everything for admin" do
      expect(policy_scope(build(:admin))).to match [book1, book2]
    end
  end
end
