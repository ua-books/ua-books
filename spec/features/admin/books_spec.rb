require "rails_helper"

RSpec.describe "Admin::BooksController" do
  specify "#create" do
    visit "/admin/books/new"

    expect(page).to have_css :h1, text: %r{^Книги / Додати$}
    expect(page.title).to eq "Книги / Додати | Admin"

    fill_in "Назва", with: "Ведмідь не хоче спати"
    fill_in "Кількість сторінок", with: "30"
    fill_in "Опис", with: "Опис цієї книги"
    select_date Date.new(2016, 10, 10), from: "Дата подання до друку"
    fill_in "Посилання на книгу на сайті видавця", with: "https://starylev.com.ua/"
    attach_file "Обкладинка", "public/system/dragonfly/development/oksana-bula-vedmid.jpg"
    click_on "Додати книгу"

    expect(page).to have_content "Запис було успішно створено"
    expect(page).to have_css :h1, text: /^Книги$/
    expect(page).to have_link "Ведмідь не хоче спати", href: "https://starylev.com.ua/"
    expect(page).to have_content "Oct 2016"

    click_on "правити"
    expect(page).to have_field "Назва", with: "Ведмідь не хоче спати"
    expect(page).to have_field "Кількість сторінок", with: "30"
    expect(page).to have_field "Опис", with: "Опис цієї книги"
    expect(page).to have_field "Дата подання до друку", with: "2016-10-10"
    expect(page).to have_field "Посилання на книгу на сайті видавця", with: "https://starylev.com.ua/"
  end

  specify "#create with a prefilled form" do
    visit "/admin/books/new?book[title]=#{CGI.escape "Ведмідь"}"

    fill_in "Кількість сторінок", with: "30"
    click_on "Додати книгу"

    expect(page).to have_content "Запис було успішно створено"

    click_on "правити"
    expect(page).to have_field "Назва", with: "Ведмідь"
  end

  specify "#update" do
    book = create(:book, title: "Зубр шукає гніздо")

    visit "/admin/books/#{book.id}/edit"

    expect(page).to have_css :h1, text: %r{^Книги / Зубр шукає гніздо / Правити$}
    expect(page.title).to eq "Книги / Зубр шукає гніздо / Правити | Admin"

    fill_in "Назва", with: "Ведмідь не хоче спати"
    click_on "Зберегти правки"

    expect(page).to have_content "Запис було успішно оновлено"

    click_on "правити"
    expect(page).to have_field "Назва", with: "Ведмідь не хоче спати"
  end
end
