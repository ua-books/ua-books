require "rails_helper"

RSpec.describe Admin::HomePolicy do
  let(:policy) { described_class }

  permissions :show? do
    it "denies access to just registered user" do
      expect(policy).not_to permit(build(:user), :home)
    end

    it "grants access to publisher" do
      expect(policy).to permit(build(:publisher_user), :home)
    end

    it "grants access to admin" do
      expect(policy).to permit(build(:admin), :home)
    end
  end
end
