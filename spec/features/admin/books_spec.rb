require "rails_helper"

RSpec.describe "Books" do
  specify "#index" do
    create(:book, title: "Зубр шукає гніздо")

    visit "/admin/books/"
    expect(page).to have_css :h1, text: /^Books$/
    expect(page).to have_content "Зубр шукає гніздо"

    expect(page.title).to eq "Books | Admin"
  end

  specify "#create" do
    visit "/admin/books/new"

    expect(page).to have_css :h1, text: %r{^Books / New$}
    expect(page.title).to eq "Books / New | Admin"

    fill_in "Title", with: "Ведмідь не хоче спати"
    fill_in "Number of pages", with: "30"
    click_on "Create Book"

    expect(page).to have_css :h1, text: /^Books$/
    expect(page).to have_content "Ведмідь не хоче спати"
  end

  specify "#update" do
    book = create(:book, title: "Зубр шукає гніздо")

    visit "/admin/books/#{book.id}/edit"

    expect(page).to have_css :h1, text: %r{^Books / Зубр шукає гніздо / Edit$}
    expect(page.title).to eq "Books / Зубр шукає гніздо / Edit | Admin"

    fill_in "Title", with: "Ведмідь не хоче спати"
    click_on "Update Book"

    expect(page).to have_css :h1, text: /^Books$/
    expect(page).to have_content "Ведмідь не хоче спати"
  end
end
