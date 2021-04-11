require "rails_helper"

RSpec.describe JsonLdHelper do
  describe "#book_as_json_ld" do
    specify "base fields" do
      publisher = build(
        :publisher,
        id: 7,
        name: "Видавництво Старого Лева",
      )

      book = create(
        :book,
        id: 3,
        title: "Зубр шукає гніздо",
        number_of_pages: 60,
        published_on: Date.new(2020, 5, 3),
        publisher: publisher,
      )

      result = helper.book_as_json_ld(book)

      expect(result).to eq(
        "@context": "https://schema.org",
        "@type": "Book",
        "@id": "http://test.host/3",
        "url": "http://test.host/3",
        "name": "Зубр шукає гніздо",
        "inLanguage": "uk",
        "numberOfPages": 60,
        "datePublished": Date.new(2020, 5, 3),
        "publisher": {
          "@type": "Organization",
          "@id": "http://test.host/p/7",
          "url": "http://test.host/p/7",
          "name": "Видавництво Старого Лева",
        }
      )
    end

    specify "isbn" do
      book = create(:book, isbn: "9786177538492")

      result = helper.book_as_json_ld(book)

      expect(result).to include(
        isbn: "9786177538492",
      )
    end

    specify "cover image" do
      book = create(:book, cover_uid: "336.jpg")

      result = helper.book_as_json_ld(book)

      expect(result).to include(
        image: "https://ik.imagekit.io/uabooks/tr:w-640/336.jpg",
      )
    end

    context "contributors" do
      let(:author) { create(:author, id: 4, first_name: "Оксана", last_name: "Була") }
      let(:book) { create(:book) }

      specify "author" do
        work_type = create(:text_author_type)
        create(:work, author_alias: author.main_alias, type: work_type, book: book)

        result = helper.book_as_json_ld(book)

        expect(result).to include(
          author: [{
            "@type": "Person",
            "@id": "http://test.host/a/4",
            "url": "http://test.host/a/4",
            "name": "Оксана Була",
          }]
        )
      end

      specify "illustrator" do
        work_type = create(:illustrator_type)
        create(:work, author_alias: author.main_alias, type: work_type, book: book)

        result = helper.book_as_json_ld(book)

        expect(result).to include(
          illustrator: [{
            "@type": "Person",
            "@id": "http://test.host/a/4",
            "url": "http://test.host/a/4",
            "name": "Оксана Була",
          }]
        )
      end

      specify "editor" do
        work_type = create(:chief_editor_type)
        create(:work, author_alias: author.main_alias, type: work_type, book: book)

        result = helper.book_as_json_ld(book)

        expect(result).to include(
          editor: [{
            "@type": "Person",
            "@id": "http://test.host/a/4",
            "url": "http://test.host/a/4",
            "name": "Оксана Була",
          }]
        )
      end

      specify "translator" do
        work_type = create(:en_translator_type)
        create(:work, author_alias: author.main_alias, type: work_type, book: book)

        result = helper.book_as_json_ld(book)

        expect(result).to include(
          translator: [{
            "@type": "Person",
            "@id": "http://test.host/a/4",
            "url": "http://test.host/a/4",
            "name": "Оксана Була",
          }]
        )
      end

      specify "contributor" do
        work_type = create(:project_manager)
        create(:work, author_alias: author.main_alias, type: work_type, book: book)

        result = helper.book_as_json_ld(book)

        expect(result).to include(
          contributor: [{
            "@type": "Person",
            "@id": "http://test.host/a/4",
            "url": "http://test.host/a/4",
            "name": "Оксана Була",
          }]
        )
      end
    end
  end
end
