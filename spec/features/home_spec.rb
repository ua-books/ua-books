require "rails_helper"

RSpec.describe "Home page" do
  specify "visiting" do
    visit "/"
    expect(page).to have_css :h1, text: /^Українські книжки$/
    expect(page.title).to eq "Українські книжки"
  end
end
