require "rails_helper"

RSpec.describe "Admin::HomeController" do

  include_examples "features" do
    let(:page_url) { admin_root_path }
  end

  specify "#index admin" do
    admin = create(:admin)

    visit admin_root_path
    sign_in_as admin

    expect(page).to have_css :h1, text: /^Адмін панель$/
    expect(page.title).to eq "Адмін панель | Admin"

    expect(page).to have_link "Книги", href: admin_books_path
    expect(page).to have_link "Автори", href: admin_authors_path
    expect(page).to have_link "Типи робіт", href: admin_work_types_path
    expect(page).to have_link "Видавництва", href: admin_publishers_path
  end

  specify "#index publisher" do
    publisher = create(:publisher, name: "Старий Лев")
    publisher_user = create(:publisher_user, publisher: publisher)

    visit admin_root_path
    sign_in_as publisher_user

    expect(page).to have_css :h1, text: /^Видавництво «Старий Лев»$/
    expect(page.title).to eq "Видавництво «Старий Лев» | Admin"

    expect(page).to have_link "Книги", href: admin_books_path
    expect(page).to have_link "Автори", href: admin_authors_path
    expect(page).to have_link "Типи робіт", href: admin_work_types_path
    expect(page).not_to have_link "Видавництва", href: admin_publishers_path
  end
end
