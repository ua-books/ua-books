require "rails_helper"

RSpec.describe "Admin::WorkController" do
  let(:publisher) { create(:publisher) }
  let!(:text_author_type) { create(:text_author_type) }
  let!(:zubr_book) { create(:book, publisher: publisher, title: "Зубр шукає гніздо") }
  let!(:oksana_bula) { create(:author, first_name: "Оксана", last_name: "Була") }

  let(:admin) { create(:admin) }
  let(:publisher_user) { create(:publisher_user, publisher: publisher) }

  include_examples "features" do
    let(:page_url) { admin_works_path }
  end

  %i[admin publisher_user].each do |user|
    specify "#index #{user}" do
      create(:work, book: zubr_book, type: text_author_type, author_alias: oksana_bula.main_alias, notes: "2008")

      visit admin_works_path
      sign_in_as public_send(user)

      expect(page).to have_css :h1, text: /^Роботи$/
      expect(page.title).to eq "Роботи | Admin"

      expect(page).to have_content "Зубр шукає гніздо"
      expect(page).to have_content "Авторка тексту"
      expect(page).to have_content "Оксана Була"
      expect(page).to have_content "2008"

      click_on "правити"
      expect(page).to have_content "Роботи / Зубр шукає гніздо - Авторка тексту - Оксана Була / Правити"
    end

    specify "#create #{user}" do
      visit new_admin_work_path(work: {book_id: zubr_book})
      sign_in_as public_send(user)

      expect(page).to have_css :h1, text: %r{^Роботи / Додати$}
      expect(page.title).to eq "Роботи / Додати | Admin"

      check "У заголовку"
      select "Автор тексту", from: "Тип робіт"
      select "Оксана Була", from: "Ім'я / Псевдонім"
      fill_in "Примітки", with: "2008"
      click_on "Додати роботу"

      expect(page).to have_content "Запис було успішно створено"
      expect(page).to have_content "Роботи до книги «Зубр шукає гніздо»"

      visit edit_admin_work_path(Work.last)

      expect(page).to have_checked_field "У заголовку"
      expect(page).to have_select "Книга", selected: "Зубр шукає гніздо"
      expect(page).to have_select "Тип робіт", selected: "Автор тексту"
      expect(page).to have_select "Псевдонім", selected: "Оксана Була"
      expect(page).to have_field "Примітки", with: "2008"
    end

    specify "#update #{user}" do
      create(:illustrator_type)
      work = create(:work, book: zubr_book, type: text_author_type, author_alias: oksana_bula.main_alias)

      visit edit_admin_work_path(work)
      sign_in_as public_send(user)

      expect(page).to have_css :h1, text: %r{^Роботи / Зубр шукає гніздо - Авторка тексту - Оксана Була / Правити$}
      expect(page.title).to eq "Роботи / Зубр шукає гніздо - Авторка тексту - Оксана Була / Правити | Admin"

      select "Ілюстратор", from: "Тип робіт"
      click_on "Зберегти правки"

      expect(page).to have_content "Запис було успішно оновлено"

      visit edit_admin_work_path(work)
      expect(page).to have_select "Тип робіт", selected: "Ілюстратор"
    end
  end
end
