require "rails_helper"

RSpec.describe "Admin::WorkController" do
  specify "#create" do
    create(:text_author_type)
    create(:book, title: "Зубр шукає гніздо")
    create(:person, first_name: "Оксана", last_name: "Була")

    visit "/admin/works/new"

    expect(page).to have_css :h1, text: %r{^Works / New$}
    expect(page.title).to eq "Works / New | Admin"

    select "Зубр шукає гніздо", from: "Book"
    select "Автор тексту", from: "Type"
    select "Оксана Була", from: "Person alias"
    click_on "Create Work"

    expect(page).to have_css :h1, text: /^Works$/
    expect(page).to have_content "Зубр шукає гніздо"
    expect(page).to have_content "Авторка тексту"
    expect(page).to have_content "Оксана Була"
  end

  specify "#update" do
    create(:illustrator_type)
    text_author_type = create(:text_author_type)
    book = create(:book, title: "Зубр шукає гніздо")
    oksana_bula = create(:person, first_name: "Оксана", last_name: "Була")
    work = Work.create!(book: book, type: text_author_type, person_alias: oksana_bula.main_alias)

    visit "/admin/works/#{work.id}/edit"

    expect(page).to have_css :h1, text: %r{^Works / Зубр шукає гніздо - Авторка тексту - Оксана Була / Edit$}
    expect(page.title).to eq "Works / Зубр шукає гніздо - Авторка тексту - Оксана Була / Edit | Admin"

    select "Ілюстратор", from: "Type"
    click_on "Update Work"

    expect(page).to have_css :h1, text: /^Works$/
    expect(page).to have_content "Ілюстраторка"
  end
end
