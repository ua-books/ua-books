require "rails_helper"

RSpec.describe "Admin::WorkTypesController" do
  specify "#create" do
    visit "/admin/work_types/new"

    expect(page).to have_css :h1, text: %r{^Work types / New$}
    expect(page.title).to eq "Work types / New | Admin"

    fill_in "Name feminine", with: "Авторка тексту"
    fill_in "Name masculine", with: "Автор тексту"
    click_on "Create Work type"

    expect(page).to have_css :h1, text: /^Work types$/
    expect(page).to have_content "Авторка тексту"
    expect(page).to have_content "Автор тексту"
  end

  specify "#update" do
    illustrator_type = create(:illustrator_type, name_masculine: "Ілюстратор")

    visit "/admin/work_types/#{illustrator_type.id}/edit"

    expect(page).to have_css :h1, text: %r{^Work types / Ілюстратор / Edit$}
    expect(page.title).to eq "Work types / Ілюстратор / Edit | Admin"

    fill_in "Name masculine", with: "Художник"
    click_on "Update Work type"

    expect(page).to have_css :h1, text: /^Work types$/
    expect(page).to have_content "Художник"
  end
end
