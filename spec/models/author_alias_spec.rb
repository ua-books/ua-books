require "rails_helper"

RSpec.describe AuthorAlias do
  describe "#main" do
    specify "default alias is main" do
      author = create(:author)
      expect(author.main_alias).to be_main
    end

    specify "two main aliases for the same author is not allowed" do
      author = create(:author, aliases: [build(:author_alias, main: false)])

      expect {
        create(:author_alias, main: true, author: author)
        create(:author_alias, main: true, author: author)
      }.to raise_error(ActiveRecord::RecordNotUnique)
    end

    specify "two secondary aliases for the same author is allowed" do
      author = create(:author, aliases: [build(:author_alias, main: false)])

      create(:author_alias, main: false, author: author)
      create(:author_alias, main: false, author: author)
    end

    specify "two main aliases for different authors is allowed" do
      create(:author, aliases: [build(:author_alias, main: true)])
      create(:author, aliases: [build(:author_alias, main: true)])
    end
  end

  describe "#set_as_main" do
    specify "does nothing if it is main already" do
      main_alias = build(:author_alias, main: true)
      create(:author, aliases: [main_alias])
      expect {
        main_alias.set_as_main
      }.not_to change { main_alias.attributes }
    end

    specify "redefines self as main" do
      author = create(:author, aliases: [build(:author_alias, main: true)])
      secondary_alias = create(:author_alias, main: false, author: author)
      expect {
        secondary_alias.set_as_main
      }.to change { secondary_alias.main }.from(false).to(true)
    end

    specify "does not touch other authors" do
      first_author_main_alias = create(:author).main_alias
      second_author_secondary_alias = create(:author_alias, main: false, author: create(:author))
      expect {
        second_author_secondary_alias.set_as_main
      }.not_to change { first_author_main_alias.main }
    end

    specify "updates author first and last name" do
      author = create(:author, first_name: "Оксана", last_name: "Була")
      secondary_alias = create(:author_alias, main: false, first_name: "Повелителька", last_name: "Туконів", author: author)
      secondary_alias.set_as_main
      expect(author.first_name).to eq "Повелителька"
      expect(author.last_name).to eq "Туконів"
    end
  end
end
