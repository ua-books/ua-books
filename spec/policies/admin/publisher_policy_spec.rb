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
end
