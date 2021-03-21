require "rails_helper"

RSpec.describe "AuthorsController" do
  let(:oksana) { create(:author, first_name: "Оксана", last_name: "Була") }
  let(:text_author_type) { create(:text_author_type) }

  specify "#show" do
    book = create(:book, :published, title: "Зубр шукає гніздо")
    create(:work, author_alias: oksana.main_alias, book: book, type: text_author_type)

    visit author_path(id: oksana)
    expect(page).to have_css :h1, text: /^Оксана Була$/

    expect(page).to have_text "Авторка тексту"
    expect(page).to have_link("Оксана Була «Зубр шукає гніздо»", href: "/#{CGI.escape "оксана-була-зубр-шукає-гніздо"}/#{book.id}")

    expect(page.title).to eq "Оксана Була на Українських книжках"
    expect(page).to have_css "link[rel='canonical'][href='http://www.example.com/#{CGI.escape "оксана-була"}/a/#{oksana.id}']", visible: false
  end

  specify "draft book is not visible" do
    draft_book = create(:book, title: "Зубр шукає гніздо")
    create(:work, author_alias: oksana.main_alias, book: draft_book, type: text_author_type)

    published_book = create(:book, :published, title: "Ведмідь не хоче спати")
    create(:work, author_alias: oksana.main_alias, book: published_book, type: text_author_type)

    visit author_path(id: oksana)
    expect(page).to have_css :h1, text: /^Оксана Була$/
    expect(page).to have_content("Авторка тексту")
    expect(page).to_not have_content("Зубр шукає гніздо")
    expect(page).to have_content("Ведмідь не хоче спати")
  end

  specify "page is not visible when there's no published books", realistic_error_responses: true do
    draft_book = create(:book, title: "Зубр шукає гніздо")
    create(:work, author_alias: oksana.main_alias, book: draft_book, type: text_author_type)

    visit author_path(id: oksana)
    expect(page).to have_content "The page you were looking for doesn't exist."
  end

  specify "different types of work" do
    book1 = create(:book, :published, title: "Зубр шукає гніздо")
    book2 = create(:book, :published, title: "Ведмідь не хоче спати")
    book3 = create(:book, :published, title: "Туконі. Мешканець лісу")

    create(:work, author_alias: oksana.main_alias, book: book1, type: text_author_type)
    create(:work, author_alias: oksana.main_alias, book: book2, type: text_author_type)
    oksana_alias = AuthorAlias.create!(author: oksana, first_name: "Придумувачка", last_name: "Туконі")
    create(:work, author_alias: oksana_alias, book: book3, type: create(:illustrator_type))

    visit author_path(id: oksana)

    expect(page).to have_text "Авторка тексту Оксана Була «Зубр шукає гніздо» Оксана Була «Ведмідь не хоче спати» Ілюстраторка Придумувачка Туконі «Туконі. Мешканець лісу»"

    expect(page).to have_link("Оксана Була «Зубр шукає гніздо»")
    expect(page).to have_link("Оксана Була «Ведмідь не хоче спати»")
    expect(page).to have_link("Придумувачка Туконі «Туконі. Мешканець лісу»")
  end

  specify "recent books are shown on top" do
    book1 = create(:book, :published, title: "Book 1", published_on: Date.new(2021, 2, 10))
    book2 = create(:book, :published, title: "Book 2", published_on: Date.new(2021, 5, 10))
    book3 = create(:book, :published, title: "Book 3", published_on: Date.new(2021, 4, 10))

    create(:work, author_alias: oksana.main_alias, book: book1, type: text_author_type)
    create(:work, author_alias: oksana.main_alias, book: book2, type: text_author_type)
    create(:work, author_alias: oksana.main_alias, book: book3, type: text_author_type)

    visit author_path(id: oksana)
    expect(page).to have_content "Оксана Була «Book 2» Оксана Була «Book 3» Оксана Була «Book 1»"
  end
end
