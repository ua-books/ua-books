require "rails_helper"

RSpec.describe "Admin::PublishersController" do
  let(:admin) { create(:admin) }

  include_examples "features" do
    let(:page_url) { "/admin/publishers" }
  end

  specify "#index" do
    book = create(:publisher,
                  name: "Старий Лев")

    visit "/admin/publishers"
    sign_in_as admin

    expect(page).to have_css :h1, text: /^Видавництва$/
    expect(page.title).to eq "Видавництва | Admin"
    expect(page).to have_content "Старий Лев"

    click_on "правити"
    expect(page).to have_content "Видавництва / Старий Лев / Правити"
  end

  specify "#create" do
    visit "/admin/publishers/new"
    sign_in_as admin

    expect(page).to have_css :h1, text: %r{^Видавництва / Додати$}
    expect(page.title).to eq "Видавництва / Додати | Admin"

    fill_in "Назва", with: "Видавництво Старого Лева"
    click_on "Додати видавництво"

    expect(page).to have_content "Запис було успішно створено"

    visit "/admin/publishers/#{Publisher.last.id}/edit"

    expect(page).to have_field "Назва", with: "Видавництво Старого Лева"
  end

  specify "#update" do
    publisher = create(:publisher, name: "Видавництво Старого Лева")

    visit "/admin/publishers/#{publisher.id}/edit"
    sign_in_as admin

    expect(page).to have_css :h1, text: %r{^Видавництва / Видавництво Старого Лева / Правити$}
    expect(page.title).to eq "Видавництва / Видавництво Старого Лева / Правити | Admin"

    fill_in "Назва", with: "Старий Лев"
    click_on "Зберегти правки"

    expect(page).to have_content "Запис було успішно оновлено"

    visit "/admin/publishers/#{publisher.id}/edit"
    expect(page).to have_field "Назва", with: "Старий Лев"
  end
end
