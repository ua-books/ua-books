require "rails_helper"

RSpec.describe "Static page" do
  specify "/about" do
    visit static_path(path: "about")
    expect(page).to have_content "Про нас"
    expect(page.title).to eq "Про нас на Українських книжках"
  end

  specify "/helping-us" do
    visit static_path(path: "helping-us")
    expect(page).to have_content "Як можна допомогти"
    expect(page.title).to eq "Як можна допомогти на Українських книжках"
  end
end
