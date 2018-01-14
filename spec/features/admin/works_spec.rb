require "rails_helper"

RSpec.describe "Admin::WorkController" do
  specify "#create" do
    create(:text_author_type)
    create(:book, title: "Зубр шукає гніздо")
    create(:person, first_name: "Оксана", last_name: "Була")

    visit "/admin/works/new"

    expect(page).to have_css :h1, text: %r{^Роботи / Додати$}
    expect(page.title).to eq "Роботи / Додати | Admin"

    check "Title"
    select "Зубр шукає гніздо", from: "Book"
    select "Автор тексту", from: "Type"
    select "Оксана Була", from: "Person alias"
    fill_in "Notes", with: "2008"
    click_on "Create Work"

    expect(page).to have_css :h1, text: /^Роботи$/
    expect(page).to have_content "Зубр шукає гніздо"
    expect(page).to have_content "Авторка тексту"
    expect(page).to have_content "Оксана Була"
    expect(page).to have_content "2008"
  end

  specify "#update" do
    create(:illustrator_type)
    text_author_type = create(:text_author_type)
    book = create(:book, title: "Зубр шукає гніздо")
    oksana_bula = create(:person, first_name: "Оксана", last_name: "Була")
    work = Work.create!(book: book, type: text_author_type, person_alias: oksana_bula.main_alias)

    visit "/admin/works/#{work.id}/edit"

    expect(page).to have_css :h1, text: %r{^Роботи / Зубр шукає гніздо - Авторка тексту - Оксана Була / Правити$}
    expect(page.title).to eq "Роботи / Зубр шукає гніздо - Авторка тексту - Оксана Була / Правити | Admin"

    select "Ілюстратор", from: "Type"
    click_on "Зберегти правки"

    expect(page).to have_css :h1, text: /^Роботи$/
    expect(page).to have_content "Ілюстраторка"
  end
end
