require "rails_helper"

RSpec.describe "Home page" do
  specify "visiting" do
    book = create(:book, title: "Зубр шукає гніздо")
    oksana = create(:person, first_name: "Оксана", last_name: "Була")
    create(:work, person_alias: oksana.main_alias, book: book)

    visit "/"
    expect(page).to have_css :h1, text: /^Українські книжки$/
    expect(page.title).to eq "Українські книжки"
    expect(page).to have_link("Оксана Була «Зубр шукає гніздо»", href: "/#{book.id}")
  end
end
