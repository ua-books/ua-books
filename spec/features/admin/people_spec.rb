require "rails_helper"

RSpec.describe "Admin::PeopleController" do
  let(:admin) { create(:admin) }

  include_examples "authentication" do
    let(:page_url) { "/admin/people" }
  end

  specify "#create" do
    visit "/admin/people/new"
    sign_in_as admin

    expect(page).to have_css :h1, text: %r{^Персони / Додати$}
    expect(page.title).to eq "Персони / Додати | Admin"

    fill_in "Ім'я", with: "Дмитро"
    fill_in "Прізвище", with: "Яворницький"
    select "чоловіча", from: "Стать"
    click_on "Додати персону"

    expect(page).to have_content "Запис було успішно створено"
    expect(page).to have_css :h1, text: /^Персони$/
    expect(page).to have_content "Дмитро"
    expect(page).to have_content "Яворницький"

    click_on "правити"
    expect(page).to have_field "Ім'я", with: "Дмитро"
    expect(page).to have_field "Прізвище", with: "Яворницький"
    expect(page).to have_select "Стать", selected: "чоловіча"
  end

  specify "#update" do
    oksana = create(:person, first_name: "Оксана", last_name: "Була")

    visit "/admin/people/#{oksana.id}/edit"
    sign_in_as admin

    expect(page).to have_css :h1, text: %r{^Персони / Оксана Була / Правити$}
    expect(page.title).to eq "Персони / Оксана Була / Правити | Admin"

    fill_in "Ім'я", with: "Галина"
    click_on "Зберегти правки"

    expect(page).to have_content "Запис було успішно оновлено"

    click_on "правити"
    expect(page).to have_field "Ім'я", with: "Галина"
  end
end
