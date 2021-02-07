require "rails_helper"

RSpec.describe "Admin::AuthorsController" do
  let(:admin) { create(:admin) }
  let(:publisher_user) { create(:publisher_user) }

  include_examples "features" do
    let(:page_url) { admin_authors_path }
  end

  %i[admin publisher_user].each do |user|
    specify "#create #{user}" do
      visit new_admin_author_path
      sign_in_as public_send(user)

      expect(page).to have_css :h1, text: %r{^Автори / Додати$}
      expect(page.title).to eq "Автори / Додати | Admin"

      fill_in "Ім'я", with: "Дмитро"
      fill_in "Прізвище", with: "Яворницький"
      select "чоловіча", from: "Стать"
      click_on "Додати автора"

      expect(page).to have_content "Запис було успішно створено"
      expect(page).to have_css :h1, text: /^Автори$/
      expect(page).to have_content "Дмитро Яворницький"

      if user == :admin
        click_on "правити"
        expect(page).to have_field "Ім'я", with: "Дмитро"
        expect(page).to have_field "Прізвище", with: "Яворницький"
        expect(page).to have_select "Стать", selected: "чоловіча"
      end
    end
  end

  specify "#update" do
    oksana = create(:author, first_name: "Оксана", last_name: "Була")

    visit edit_admin_author_path(oksana)
    sign_in_as admin

    expect(page).to have_css :h1, text: %r{^Автори / Оксана Була / Правити$}
    expect(page.title).to eq "Автори / Оксана Була / Правити | Admin"

    fill_in "Ім'я", with: "Галина"
    click_on "Зберегти правки"

    expect(page).to have_content "Запис було успішно оновлено"

    click_on "правити"
    expect(page).to have_field "Ім'я", with: "Галина"
  end
end
