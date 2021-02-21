require "rails_helper"

RSpec.describe Admin::AuthorAliasPolicy do
  let(:policy) { described_class }

  permissions :index? do
    it "denies access to just registered user" do
      expect(policy).not_to permit(build(:user), AuthorAlias.new)
    end

    it "grants access to publisher" do
      expect(policy).to permit(build(:publisher_user), AuthorAlias.new)
    end

    it "grants access to admin" do
      expect(policy).to permit(build(:admin), AuthorAlias.new)
    end
  end

  permissions :new?, :create? do
    it "denies access to just registered user" do
      expect(policy).not_to permit(build(:user), AuthorAlias.new)
    end

    it "grants access to publisher" do
      expect(policy).to permit(build(:publisher_user), AuthorAlias.new)
    end

    it "grants access to admin" do
      expect(policy).to permit(build(:admin), AuthorAlias.new)
    end
  end

  permissions :edit?, :update?, :set_as_main? do
    it "denies access to just registered user" do
      expect(policy).not_to permit(build(:user), AuthorAlias.new)
    end

    it "denies access to publisher" do
      expect(policy).not_to permit(build(:publisher_user), AuthorAlias.new)
    end

    it "grants access to admin" do
      expect(policy).to permit(build(:admin), AuthorAlias.new)
    end
  end

  describe "scope" do
    def policy_scope(user)
      Pundit.policy_scope!(user, [:admin, AuthorAlias])
    end

    let(:author_alias_1) { build(:author_alias) }
    let(:author_alias_2) { build(:author_alias) }
    let!(:author) { create(:author, aliases: [author_alias_1, author_alias_2]) }

    it "returns nothing for just registered user" do
      expect(policy_scope(build(:user))).to be_empty
    end

    it "returns everything for publisher" do
      expect(policy_scope(build(:publisher_user))).to match [author_alias_1, author_alias_2]
    end

    it "returns everything for admin" do
      expect(policy_scope(build(:admin))).to match [author_alias_1, author_alias_2]
    end
  end
end
