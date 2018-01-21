require "rails_helper"

RSpec.describe "Admin::WorkController" do
  let!(:text_author_type) { create(:text_author_type) }
  let!(:zubr_book) { create(:book, title: "Зубр шукає гніздо") }
  let!(:oksana_bula) { create(:person, first_name: "Оксана", last_name: "Була") }

  specify "#index" do
    create(:work, book: zubr_book, type: text_author_type, person_alias: oksana_bula.main_alias, notes: "2008")

    visit "/admin/works"

    expect(page).to have_css :h1, text: /^Роботи$/
    expect(page.title).to eq "Роботи | Admin"

    expect(page).to have_content "Зубр шукає гніздо"
    expect(page).to have_content "Авторка тексту"
    expect(page).to have_content "Оксана Була"
    expect(page).to have_content "2008"

    click_on "правити"
    expect(page).to have_content "Роботи / Зубр шукає гніздо - Авторка тексту - Оксана Була / Правити"
  end

  specify "#create" do
    visit "/admin/works/new"

    expect(page).to have_css :h1, text: %r{^Роботи / Додати$}
    expect(page.title).to eq "Роботи / Додати | Admin"

    check "У заголовку"
    select "Зубр шукає гніздо", from: "Книга"
    select "Автор тексту", from: "Тип робіт"
    select "Оксана Була", from: "Ім'я / Псевдонім"
    fill_in "Примітки", with: "2008"
    click_on "Додати роботу"

    expect(page).to have_content "Запис було успішно створено"
    expect(page).to have_content "Роботи до книги «Зубр шукає гніздо»"

    visit "/admin/works/#{Work.last.id}/edit"

    expect(page).to have_checked_field "У заголовку"
    expect(page).to have_select "Книга", selected: "Зубр шукає гніздо"
    expect(page).to have_select "Тип робіт", selected: "Автор тексту"
    expect(page).to have_select "Псевдонім", selected: "Оксана Була"
    expect(page).to have_field "Примітки", with: "2008"
  end

  specify "#update" do
    create(:illustrator_type)
    work = create(:work, book: zubr_book, type: text_author_type, person_alias: oksana_bula.main_alias)

    visit "/admin/works/#{work.id}/edit"

    expect(page).to have_css :h1, text: %r{^Роботи / Зубр шукає гніздо - Авторка тексту - Оксана Була / Правити$}
    expect(page.title).to eq "Роботи / Зубр шукає гніздо - Авторка тексту - Оксана Була / Правити | Admin"

    select "Ілюстратор", from: "Тип робіт"
    click_on "Зберегти правки"

    expect(page).to have_content "Запис було успішно оновлено"

    visit "/admin/works/#{work.id}/edit"
    expect(page).to have_select "Тип робіт", selected: "Ілюстратор"
  end
end
