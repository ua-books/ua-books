require "rails_helper"

RSpec.describe Admin::WorkPolicy do
  let(:policy) { described_class }

  permissions :index? do
    it "denies access to just registered user" do
      expect(policy).not_to permit(build(:user), Work.new)
    end

    it "grants access to publisher" do
      expect(policy).to permit(build(:publisher_user), Work.new)
    end

    it "grants access to admin" do
      expect(policy).to permit(build(:admin), Work.new)
    end
  end

  permissions :new?, :create? do
    let(:publisher) { create(:publisher) }
    let(:book) { create(:book, publisher: publisher) }

    it "denies access to just registered user" do
      expect(policy).not_to permit(build(:user), Work.new)
      expect(policy).not_to permit(build(:user), Work.new(book: book))
    end

    it "grants access to publisher" do
      user = build(:publisher_user, publisher: publisher)
      expect(policy).to permit(user, Work.new(book: book))
    end

    it "denies access to other publisher" do
      user = build(:publisher_user)
      expect(policy).not_to permit(user, Work.new(book: book))
    end

    it "grants access to admin" do
      expect(policy).to permit(build(:admin), Work.new(book: book))
    end
  end

  permissions :edit?, :update? do
    let(:publisher) { create(:publisher) }
    let(:book) { create(:book, publisher: publisher) }
    let(:work) { Work.create!(book: book, person_alias: create(:author).main_alias, type: create(:text_author_type)) }

    it "denies access to just registered user" do
      expect(policy).not_to permit(build(:user), work)
    end

    it "grants access to publisher" do
      user = build(:publisher_user, publisher: publisher)
      expect(policy).to permit(user, work)
    end

    it "denies access to other publisher" do
      user = build(:publisher_user)
      expect(policy).not_to permit(user, work)
    end

    it "grants access to admin" do
      expect(policy).to permit(build(:admin), work)
    end
  end

  describe "scope" do
    def policy_scope(user)
      Pundit.policy_scope!(user, [:admin, Work])
    end

    let(:publisher) { create(:publisher) }
    let(:author) { create(:author) }
    let(:work_type) { create(:text_author_type) }

    let!(:book1) { create(:book, publisher: publisher) }
    let!(:work1) { Work.create!(book: book1, person_alias: author.main_alias, type: work_type) }

    let!(:book2) { create(:book) }
    let!(:work2) { Work.create!(book: book2, person_alias: author.main_alias, type: work_type) }

    it "returns nothing for just registered user" do
      expect(policy_scope(build(:user))).to be_empty
    end

    it "returns everything for admin" do
      expect(policy_scope(build(:admin))).to match [work1, work2]
    end

    it "returns publisher's works for publisher" do
      user = build(:publisher_user, publisher: publisher)
      expect(policy_scope(user)).to eq [work1]
    end

    it "returns nothing for other publisher" do
      user = build(:publisher_user)
      expect(policy_scope(user)).to be_empty
    end
  end
end
