require "rails_helper"

RSpec.describe "BooksController" do
  specify "#show" do
    book = create(:book,
                  title: "Зубр шукає гніздо",
                  number_of_pages: 32,
                  published_on: "2016-09-16")

    oksana = create(:person, :with_alias, first_name: "Оксана", last_name: "Була", gender: "female")
    maryana = create(:person, :with_alias, first_name: "Мар'яна", last_name: "Савка", gender: "female")

    create(:work, person_alias: oksana.main_alias, type: create(:text_author_type), book: book)
    create(:work, person_alias: oksana.main_alias, type: create(:illustrator_type), book: book)
    create(:work, person_alias: maryana.main_alias, type: create(:chief_editor_type), book: book, title: false)

    visit "/#{book.id}"
    expect(page).to have_css :h1, text: /^Оксана Була «Зубр шукає гніздо»$/
    expect(page).to have_content "Авторка тексту Оксана Була"
    expect(page).to have_content "Ілюстраторка Оксана Була"
    expect(page).to have_content "Головна редакторка Мар'яна Савка"

    expect(page).to have_content "Рік видання 2016"
    expect(page).to have_content "Кількість сторінок 32"

    expect(page.title).to eq "Оксана Була «Зубр шукає гніздо» на Українських книжках"
    expect(page).to have_css "link[rel='canonical'][href='http://www.example.com/#{CGI.escape "оксана-була-зубр-шукає-гніздо"}/#{book.id}']", visible: false
  end
end
