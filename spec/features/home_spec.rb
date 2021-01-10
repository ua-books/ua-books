require "rails_helper"

RSpec.describe "Home page" do
  specify "visiting" do
    book = create(:book, :published, title: "Зубр шукає гніздо")
    oksana = create(:author, first_name: "Оксана", last_name: "Була")
    create(:work, author_alias: oksana.main_alias, book: book)

    visit "/"
    expect(page).to have_content "Українські книжки"
    expect(page.title).to eq "Українські книжки"
    expect(page).to have_link("Оксана Була «Зубр шукає гніздо»", href: "/#{CGI.escape "оксана-була-зубр-шукає-гніздо"}/#{book.id}")
  end

  specify "draft book" do
    create(:book, title: "Зубр шукає гніздо")

    visit "/"
    expect(page).to_not have_content("Зубр шукає гніздо")
  end
end
