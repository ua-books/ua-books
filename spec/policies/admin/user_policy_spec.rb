require "rails_helper"

RSpec.describe Admin::UserPolicy do
  let(:policy) { described_class }

  permissions :index? do
    it "denies access to just registered user" do
      expect(policy).not_to permit(build(:user), User.new)
    end

    it "denies access to publisher" do
      expect(policy).not_to permit(build(:publisher_user), User.new)
    end

    it "grants access to admin" do
      expect(policy).to permit(build(:admin), User.new)
    end
  end
end
