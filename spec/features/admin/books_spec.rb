require "rails_helper"

RSpec.describe "Admin::BooksController" do
  let(:admin) { create(:admin) }
  let(:publisher_user) { create(:publisher_user, publisher: publisher) }
  let(:publisher) { create(:publisher, name: "Старий Лев") }

  include_examples "features" do
    let(:page_url) { admin_books_path }
  end

  %i[admin publisher_user].each do |user|
    specify "#index #{user}" do
      book = create(:book,
                    :published,
                    publisher: publisher,
                    title: "Зубр шукає гніздо",
                    publisher_page_url: "https://starylev.com.ua/",
                    published_on: "2016-09-16")

      visit admin_books_path
      sign_in_as public_send(user)

      expect(page).to have_css :h1, text: /^Книги$/
      expect(page.title).to eq "Книги | Admin"
      expect(page).to have_link "опубліковано", href: book_path(id: book)
      expect(page).to have_link "Зубр шукає гніздо", href: "https://starylev.com.ua/"
      expect(page).to have_content "Sep 2016"

      click_on "правити"
      expect(page).to have_content "Книги / Зубр шукає гніздо / Правити"

      visit admin_books_path
      click_on "роботи"
      expect(page).to have_content "Роботи до книги «Зубр шукає гніздо»"
    end

    specify "#index #{user} with a draft book" do
      book = create(:book, title: "Ця книга ще не опублікована на сайті", publisher: publisher)

      visit admin_books_path
      sign_in_as public_send(user)

      expect(page).to have_content "Ця книга ще не опублікована на сайті"
      expect(page).to have_link "чорновик", href: book_path(id: book)
    end

    specify "#create #{user}" do
      publisher
      visit new_admin_book_path
      sign_in_as public_send(user)

      expect(page).to have_css :h1, text: %r{^Книги / Додати$}
      expect(page.title).to eq "Книги / Додати | Admin"

      expect(page).not_to have_field "Стан"
      select "Старий Лев", from: "Видавництво"
      fill_in "Назва", with: "Ведмідь не хоче спати"
      fill_in "Кількість сторінок", with: "30"
      fill_in "ISBN", with: "978-617-7538-49-2"
      fill_in "Опис", with: "Опис цієї книги"
      select_date Date.new(2016, 10, 10), from: "Дата подання до друку"
      fill_in "Посилання на книгу на сайті видавця", with: "https://starylev.com.ua/"
      click_on "Додати книгу"

      expect(page).to have_content "Книгу було успішно додано. Будь ласка, вкажіть тих, хто над нею працював."
      expect(page).to have_content "Роботи до книги «Ведмідь не хоче спати»"

      visit edit_admin_book_path(Book.last)

      expect(page).to have_select "Стан", selected: "чорновик"
      expect(page).to have_select "Видавництво", selected: "Старий Лев"
      expect(page).to have_field "Назва", with: "Ведмідь не хоче спати"
      expect(page).to have_field "Кількість сторінок", with: "30"
      expect(page).to have_field "ISBN", with: "9786177538492"
      expect(page).to have_field "Опис", with: "Опис цієї книги"
      expect(page).to have_field "Дата подання до друку", with: "2016-10-10"
      expect(page).to have_field "Посилання на книгу на сайті видавця", with: "https://starylev.com.ua/"
    end

    specify "#create with a prefilled form (#{user})" do
      visit new_admin_book_path(book: {title: "Ведмідь"})
      sign_in_as public_send(user)
      expect(page).to have_field "Назва", with: "Ведмідь"
    end

    specify "#update #{user}" do
      book = create(:book, publisher: publisher, title: "Зубр шукає гніздо")

      visit edit_admin_book_path(book)
      sign_in_as public_send(user)

      expect(page).to have_css :h1, text: %r{^Книги / Зубр шукає гніздо / Правити$}
      expect(page.title).to eq "Книги / Зубр шукає гніздо / Правити | Admin"

      fill_in "Назва", with: "Ведмідь не хоче спати"
      click_on "Зберегти правки"

      expect(page).to have_content "Запис було успішно оновлено"

      visit edit_admin_book_path(book)
      expect(page).to have_field "Назва", with: "Ведмідь не хоче спати"
    end
  end
end
