require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe "#parameterize" do
    specify "with an author" do
      expect(helper.parameterize("Оксана Була «Зубр шукає гніздо»")).to eq "оксана-була-зубр-шукає-гніздо"
    end

    specify "without an author" do
      expect(helper.parameterize("«Зубр шукає гніздо»")).to eq "зубр-шукає-гніздо"
    end

    specify "with numerals" do
      expect(helper.parameterize("«Зубр шукає гніздо в 33 раз»")).to eq "зубр-шукає-гніздо-в-33-раз"
    end
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

  describe "#book_meta_description" do
    specify "no description" do
      book = Book.new(title: "Зубр шукає гніздо")
      expect(helper.book_meta_description(book)).to eq "Книга «Зубр шукає гніздо»"
    end

    specify "one paragraph" do
      book = Book.new(description_md: "Перший параграф")
      expect(helper.book_meta_description(book)).to eq "Перший параграф"
    end

    specify "more than one paragraph" do
      book = Book.new(description_md: "Перший параграф.\n\nДругий параграф\n\nТретій параграф.")
      expect(helper.book_meta_description(book)).to eq "Перший параграф."
    end

    specify "strip markdown formatting" do
      book = Book.new(description_md: "Перший *параграф*")
      expect(helper.book_meta_description(book)).to eq "Перший параграф"
    end
  end

  describe "#publisher_title" do
    specify "when name starts with Видав" do
      publisher1 = create(:publisher, name: "Видавництво Ранок")
      publisher2 = create(:publisher, name: "Видавець Савчук")
      publisher3 = create(:publisher, name: "Видавничий дім «Комора»")
      expect(publisher_title(publisher1)).to eq "Видавництво Ранок"
      expect(publisher_title(publisher2)).to eq "Видавець Савчук"
      expect(publisher_title(publisher3)).to eq "Видавничий дім «Комора»"
    end

    specify "when name does not start with Видав" do
      publisher1 = create(:publisher, name: "Темпора")
      publisher2 = create(:publisher, name: "# книголав")
      expect(publisher_title(publisher1)).to eq "Видавництво «Темпора»"
      expect(publisher_title(publisher2)).to eq "Видавництво «# книголав»"
    end
  end
end
