require "rails_helper"

RSpec.describe "Admin::PeopleController" do
  specify "#create" do
    visit "/admin/people/new"

    expect(page).to have_css :h1, text: %r{^People / New$}
    expect(page.title).to eq "People / New | Admin"

    fill_in "First name", with: "Дмитро"
    fill_in "Last name", with: "Яворницький"
    select "male", from: "Gender"
    click_on "Create Person"

    expect(page).to have_css :h1, text: /^People$/
    expect(page).to have_content "Дмитро"
    expect(page).to have_content "Яворницький"
  end

  specify "#update" do
    oksana = create(:person, first_name: "Оксана", last_name: "Була")

    visit "/admin/people/#{oksana.id}/edit"

    expect(page).to have_css :h1, text: %r{^People / Оксана Була / Edit$}
    expect(page.title).to eq "People / Оксана Була / Edit | Admin"

    fill_in "First name", with: "Галина"
    click_on "Update Person"

    expect(page).to have_css :h1, text: /^People$/
    expect(page).to have_content "Галина"
  end
end
