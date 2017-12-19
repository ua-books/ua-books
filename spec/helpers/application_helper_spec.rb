require 'rails_helper'

RSpec.describe ApplicationHelper do
  specify "#parameterize" do
    expect(helper.parameterize("Оксана Була «Зубр шукає гніздо»")).to eq "оксана-була-зубр-шукає-гніздо"
  end

  describe "#book_title" do
    let(:oksana) { create(:person, first_name: "Оксана", last_name: "Була") }
    let(:maryana) { create(:person, first_name: "Мар'яна", last_name: "Савка") }
    let(:book) { create(:book, title: "Зубр шукає гніздо") }

    specify "single author, single work" do
      create(:work, person_alias: oksana.main_alias, book: book)

      expect(helper.book_title(book)).to eq "Оксана Була «Зубр шукає гніздо»"
    end

    specify "single author, multiple works" do
      create(:work, person_alias: oksana.main_alias, type: create(:text_author_type), book: book)
      create(:work, person_alias: oksana.main_alias, type: create(:illustrator_type), book: book)

      expect(helper.book_title(book)).to eq "Оксана Була «Зубр шукає гніздо»"
    end

    specify "multiple authors" do
      create(:work, person_alias: oksana.main_alias, type: create(:text_author_type), book: book)
      create(:work, person_alias: maryana.main_alias, type: create(:chief_editor_type), book: book)

      expect(helper.book_title(book)).to eq "Оксана Була, Мар'яна Савка «Зубр шукає гніздо»"
    end

    specify "multiple authors, single title author" do
      create(:work, person_alias: oksana.main_alias, type: create(:text_author_type), book: book)
      create(:work, person_alias: maryana.main_alias, type: create(:chief_editor_type), book: book, title: false)

      expect(helper.book_title(book)).to eq "Оксана Була «Зубр шукає гніздо»"
    end

    specify ":works option" do
      work = create(:work, person_alias: oksana.main_alias, type: create(:text_author_type), book: book)

      expect(helper.book_title(book, works: [work])).to eq "Оксана Була «Зубр шукає гніздо»"
    end
  end
end
