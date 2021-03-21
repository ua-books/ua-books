require "rails_helper"

RSpec.describe "Home page" do
  specify "visiting" do
    book = create(:book, :published, title: "Зубр шукає гніздо")
    oksana = create(:author, first_name: "Оксана", last_name: "Була")
    create(:work, author_alias: oksana.main_alias, book: book)

    visit root_path
    expect(page).to have_content "Українські книжки"
    expect(page.title).to eq "Українські книжки"
    expect(page).to have_link("Оксана Була «Зубр шукає гніздо»", href: "/#{CGI.escape "оксана-була-зубр-шукає-гніздо"}/#{book.id}")
  end

  specify "draft book" do
    create(:book, title: "Зубр шукає гніздо")

    visit root_path
    expect(page).to_not have_content("Зубр шукає гніздо")
  end

  specify "recent books are shown on top" do
    create(:book, :published, title: "Book 1", published_on: Date.new(2021, 2, 10))
    create(:book, :published, title: "Book 2", published_on: Date.new(2021, 5, 10))
    create(:book, :published, title: "Book 3", published_on: Date.new(2021, 4, 10))

    visit root_path
    expect(page).to have_content "«Book 2» «Book 3» «Book 1»"
  end
end
