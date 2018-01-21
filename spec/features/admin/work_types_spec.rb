require "rails_helper"

RSpec.describe "Admin::WorkTypesController" do
  specify "#create" do
    visit "/admin/work_types/new"

    expect(page).to have_css :h1, text: %r{^Типи робіт / Додати$}
    expect(page.title).to eq "Типи робіт / Додати | Admin"

    fill_in "Назва (жіночий рід)", with: "Авторка тексту"
    fill_in "Назва (чоловічий рід)", with: "Автор тексту"
    click_on "Додати тип робіт"

    expect(page).to have_content "Запис було успішно створено"
    expect(page).to have_css :h1, text: /^Типи робіт$/
    expect(page).to have_content "Авторка тексту"
    expect(page).to have_content "Автор тексту"

    click_on "правити"
    expect(page).to have_field "Назва (жіночий рід)", with: "Авторка тексту"
    expect(page).to have_field "Назва (чоловічий рід)", with: "Автор тексту"
  end

  specify "#update" do
    illustrator_type = create(:illustrator_type, name_masculine: "Ілюстратор")

    visit "/admin/work_types/#{illustrator_type.id}/edit"

    expect(page).to have_css :h1, text: %r{^Типи робіт / Ілюстратор / Правити$}
    expect(page.title).to eq "Типи робіт / Ілюстратор / Правити | Admin"

    fill_in "Назва (жіночий рід)", with: "Художник"
    click_on "Зберегти правки"

    expect(page).to have_content "Запис було успішно оновлено"

    click_on "правити"
    expect(page).to have_field "Назва (жіночий рід)", with: "Художник"
  end
end
