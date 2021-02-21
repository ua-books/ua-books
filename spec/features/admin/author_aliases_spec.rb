require "rails_helper"

RSpec.describe "Admin::AuthorAliasesController" do
  let(:publisher) { create(:publisher) }
  let(:oksana_alias) { build(:author_alias, first_name: "Повелителька", last_name: "Туконів") }
  let!(:oksana_bula) { create(:author, first_name: "Оксана", last_name: "Була", aliases: [oksana_alias]) }

  let(:admin) { create(:admin) }
  let(:publisher_user) { create(:publisher_user, publisher: publisher) }

  include_examples "features" do
    let(:page_url) { admin_author_aliases_path }
  end

  %i[admin publisher_user].each do |user|
    specify "#index #{user}" do
      visit admin_author_aliases_path
      sign_in_as public_send(user)

      expect(page).to have_css :h1, text: /^Псевдоніми$/
      expect(page.title).to eq "Псевдоніми | Admin"

      expect(page).to have_content "Оксана Була Повелителька Туконів правити"

      if user == :admin
        click_on "правити"
        expect(page).to have_content "Псевдоніми / Оксана Була - Повелителька Туконів / Правити"
      end
    end

    specify "#create #{user}" do
      visit new_admin_author_alias_path(author_alias: {author_id: oksana_bula})
      sign_in_as public_send(user)

      expect(page).to have_css :h1, text: %r{^Псевдоніми / Додати$}
      expect(page.title).to eq "Псевдоніми / Додати | Admin"

      expect(page).to have_select "Автор", selected: "Оксана Була"
      fill_in "Ім'я", with: "Інший"
      fill_in "Прізвище", with: "Псевдонім"
      click_on "Додати псевдонім"

      expect(page).to have_content "Запис було успішно створено"
      expect(page).to have_content "Псевдоніми автора Оксана Була"

      if user == :admin
        visit edit_admin_author_alias_path(AuthorAlias.last)

        expect(page).to have_select "Автор", selected: "Оксана Була"
        expect(page).to have_field "Ім'я", with: "Інший"
        expect(page).to have_field "Прізвище", with: "Псевдонім"
      end
    end
  end

  specify "#update" do
    visit edit_admin_author_alias_path(oksana_alias)
    sign_in_as admin

    expect(page).to have_css :h1, text: %r{^Псевдоніми / Оксана Була - Повелителька Туконів / Правити$}
    expect(page.title).to eq "Псевдоніми / Оксана Була - Повелителька Туконів / Правити | Admin"

    fill_in "Прізвище", with: "Лісу"
    click_on "Зберегти правки"

    expect(page).to have_content "Запис було успішно оновлено"

    visit edit_admin_author_alias_path(oksana_alias)
    expect(page).to have_field "Прізвище", with: "Лісу"
  end

  specify "#set_as_main" do
    create(:author_alias, first_name: "Оксана", last_name: "Була", author: oksana_bula, main: true)

    visit admin_author_aliases_path
    sign_in_as admin

    expect(page).to have_content "Оксана Була Оксана Була правити головний"
    expect(page).to have_content "Оксана Була Повелителька Туконів правити"

    click_on "зробити головним"

    expect(page).to have_content "Повелителька Туконів Оксана Була правити"
    expect(page).to have_content "Повелителька Туконів Повелителька Туконів правити головний"
  end
end
