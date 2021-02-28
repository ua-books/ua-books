require "rails_helper"

RSpec.describe Admin::BookPolicy do
  let(:policy) { described_class }

  permissions :index? do
    it "denies access to just registered user" do
      expect(policy).not_to permit(build(:user), Book.new)
    end

    it "grants access to publisher" do
      expect(policy).to permit(build(:publisher_user), Book.new)
    end

    it "grants access to admin" do
      expect(policy).to permit(build(:admin), Book.new)
    end
  end

  permissions :new? do
    let(:publisher) { create(:publisher) }

    it "denies access to just registered user" do
      expect(policy).not_to permit(build(:user), Book.new)
      expect(policy).not_to permit(build(:user), Book.new(publisher: publisher))
    end

    it "grants access to publisher" do
      user = build(:publisher_user, publisher: publisher)
      expect(policy).to permit(user, Book.new)
      expect(policy).to permit(user, Book.new(publisher: publisher))
    end

    it "denies access to other publisher" do
      user = build(:publisher_user)
      expect(policy).not_to permit(user, Book.new(publisher: publisher))
    end

    it "grants access to admin" do
      expect(policy).to permit(build(:admin), Book.new)
    end
  end

  permissions :create? do
    let(:publisher) { create(:publisher) }

    it "denies access to just registered user" do
      expect(policy).not_to permit(build(:user), Book.new)
      expect(policy).not_to permit(build(:user), Book.new(publisher: publisher))
    end

    it "grants access to publisher" do
      user = build(:publisher_user, publisher: publisher)
      expect(policy).to permit(user, Book.new(publisher: publisher))
    end

    it "denies access to other publisher" do
      user = build(:publisher_user)
      expect(policy).not_to permit(user, Book.new(publisher: publisher))
    end

    it "grants access to admin" do
      expect(policy).to permit(build(:admin), Book.new)
    end
  end

  permissions :edit?, :update? do
    let(:publisher) { create(:publisher) }
    let(:book) { create(:book, publisher: publisher) }

    it "denies access to just registered user" do
      expect(policy).not_to permit(build(:user), book)
    end

    it "grants access to publisher" do
      user = build(:publisher_user, publisher: publisher)
      expect(policy).to permit(user, book)
    end

    it "denies access to other publisher" do
      user = build(:publisher_user)
      expect(policy).not_to permit(user, book)
    end

    it "grants access to admin" do
      expect(policy).to permit(build(:admin), book)
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
      expect(policy_scope(build(:admin))).to match_array [book1, book2]
    end

    it "returns publisher's books for publisher" do
      user = build(:publisher_user, publisher: publisher)
      expect(policy_scope(user)).to eq [book1]
    end

    it "returns nothing for other publisher" do
      user = build(:publisher_user)
      expect(policy_scope(user)).to be_empty
    end
  end
end
