require "rails_helper"

RSpec.describe Admin::WorkPolicy do
  let(:policy) { described_class }

  permissions :index?, :new?, :create?, :update?, :edit? do
    it "denies access to just registered user" do
      expect(policy).not_to permit(build(:user), Work.new)
    end

    it "grants access to admin" do
      expect(policy).to permit(build(:admin), Work.new)
    end
  end
end