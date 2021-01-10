require "rails_helper"

RSpec.describe "BooksController" do
  specify "#show when published" do
    leva_publishing = create(:publisher, name: "Старий Лев")
    book = create(:book,
                  :published,
                  publisher: leva_publishing,
                  title: "Зубр шукає гніздо",
                  description_md: "Це опис книжки про класного зубра",
                  number_of_pages: 32,
                  publisher_page_url: "https://starylev.com.ua/",
                  published_on: "2016-09-16")

    oksana = create(:author, first_name: "Оксана", last_name: "Була", gender: "female")
    maryana = create(:author, first_name: "Мар'яна", last_name: "Савка", gender: "female")

    create(:work, person_alias: oksana.main_alias, type: create(:text_author_type), book: book)
    create(:work, person_alias: oksana.main_alias, type: create(:illustrator_type), book: book, notes: "включно з обкладинкою")
    create(:work, person_alias: maryana.main_alias, type: create(:chief_editor_type), book: book, title: false)

    visit "/#{book.id}"
    expect(page).to have_css :h1, text: /^Оксана Була «Зубр шукає гніздо»$/
    expect(page).to have_content "Видавництво Старий Лев"
    expect(page).to have_link "Старий Лев", href: publisher_path(id: leva_publishing, slug: "видавництво-старий-лев")

    expect(page).to have_content "Авторка тексту Оксана Була"
    expect(page).to have_content "Ілюстраторка Оксана Була, включно з обкладинкою"
    expect(page).to have_content "Головна редакторка Мар'яна Савка"

    expect(page).to have_content "Рік видання 2016"
    expect(page).to have_content "Кількість сторінок 32"

    expect(page).to have_link "Перейти на сайт видавництва", href: "https://starylev.com.ua/"

    expect(page).to have_content "Це опис книжки про класного зубра"

    expect(page.title).to eq "Оксана Була «Зубр шукає гніздо» на Українських книжках"
    expect(page).to have_css "link[rel='canonical'][href='http://www.example.com/#{CGI.escape "оксана-була-зубр-шукає-гніздо"}/#{book.id}']", visible: false
    expect(page).to have_css "meta[name='description'][content='Це опис книжки про класного зубра']", visible: false
  end

  context "#show when draft", realistic_error_responses: true do
    let(:leva_publishing) { create(:publisher, name: "Старий Лев") }
    let(:book) { create(:book, title: "Зубр шукає гніздо", publisher: leva_publishing) }

    specify "is not allowed when visited as anonymous" do
      visit "/#{book.id}"
      expect(page).to have_content "The page you were looking for doesn't exist."
    end

    specify "is allowed when visited as admin" do
      admin = create(:admin)
      sign_in_as admin

      visit "/#{book.id}"
      expect(page).to have_content "Зубр шукає гніздо"
      expect(page).to have_content "Старий Лев"
    end

    specify "is allowed when visited as same publisher" do
      leva_publishing_user = create(:publisher_user, publisher: leva_publishing)
      sign_in_as leva_publishing_user

      visit "/#{book.id}"
      expect(page).to have_content "Зубр шукає гніздо"
      expect(page).to have_content "Старий Лев"
    end

    specify "is not allowed when visited as another publisher" do
      shady_publishing_user = create(:publisher_user)
      sign_in_as shady_publishing_user

      visit "/#{book.id}"
      expect(page).to have_content "The page you were looking for doesn't exist."
    end
  end
end
