require "rails_helper"

RSpec.describe "Books" do
  specify "#index" do
    create(:book, title: "Зубр шукає гніздо")

    visit "/admin/books/"
    expect(page).to have_css :h1, text: /^Books$/
    expect(page).to have_content "Зубр шукає гніздо"

    expect(page.title).to eq "Books | Admin"
  end
end
