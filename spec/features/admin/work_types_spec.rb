require "rails_helper"

RSpec.describe "Admin::WorkTypesController" do
  let(:admin) { create(:admin) }

  include_examples "features" do
    let(:page_url) { admin_work_types_path }
  end

  specify "#create" do
    visit new_admin_work_type_path
    sign_in_as admin

    expect(page).to have_css :h1, text: %r{^Типи робіт / Додати$}
    expect(page.title).to eq "Типи робіт / Додати | Admin"

    fill_in "Назва (жіночий рід)", with: "Авторка тексту"
    fill_in "Назва (чоловічий рід)", with: "Автор тексту"
    select "author", from: "Роль (за schema.org)"
    click_on "Додати тип робіт"

    expect(page).to have_content "Запис було успішно створено"
    expect(page).to have_css :h1, text: /^Типи робіт$/
    expect(page).to have_content "Авторка тексту Автор тексту"

    click_on "правити"
    expect(page).to have_field "Назва (жіночий рід)", with: "Авторка тексту"
    expect(page).to have_field "Назва (чоловічий рід)", with: "Автор тексту"
    expect(page).to have_select "Роль (за schema.org)", selected: "author"
  end

  specify "#update" do
    illustrator_type = create(:illustrator_type, name_masculine: "Ілюстратор")

    visit edit_admin_work_type_path(illustrator_type)
    sign_in_as admin

    expect(page).to have_css :h1, text: %r{^Типи робіт / Ілюстратор / Правити$}
    expect(page.title).to eq "Типи робіт / Ілюстратор / Правити | Admin"

    fill_in "Назва (жіночий рід)", with: "Художник"
    click_on "Зберегти правки"

    expect(page).to have_content "Запис було успішно оновлено"

    click_on "правити"
    expect(page).to have_field "Назва (жіночий рід)", with: "Художник"
  end
end
