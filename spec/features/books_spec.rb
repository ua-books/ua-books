require "rails_helper"

RSpec.describe "Books" do
  specify "visiting" do
    book = create(:book, title: "Зубр шукає гніздо")
    visit "/#{book.id}"
    expect(page).to have_content "Зубр шукає гніздо"
    expect(page.title).to eq "«Зубр шукає гніздо» на Українських книжках"
  end
end
