require "rails_helper"

RSpec.describe Admin::WorkTypePolicy do
  let(:policy) { described_class }

  permissions :index?, :new?, :create?, :update?, :edit? do
    it "denies access to just registered user" do
      expect(policy).not_to permit(build(:user), WorkType.new)
    end

    it "grants access to admin" do
      expect(policy).to permit(build(:admin), WorkType.new)
    end
  end

  describe "scope" do
    def policy_scope(user)
      Pundit.policy_scope!(user, [:admin, WorkType])
    end

    let!(:work_type1) { create(:text_author_type) }
    let!(:work_type2) { create(:illustrator_type) }

    it "returns nothing for just registered user" do
      expect(policy_scope(build(:user))).to be_empty
    end

    it "returns everything for admin" do
      expect(policy_scope(build(:admin))).to match [work_type1, work_type2]
    end
  end
end
