require "rails_helper"

RSpec.describe "Admin::UsersController" do
  include_examples "features" do
    let(:page_url) { admin_users_path }
  end

  specify "#index admin" do
    admin = create(:admin, email: "admin@test", first_name: "Admin", last_name: "User")
    publisher = create(:publisher, name: "Старий Лев")
    _publisher_user = create(:publisher_user, email: "user@lev", publisher: publisher)

    visit admin_users_path
    sign_in_as admin

    expect(page).to have_css :h1, text: %r{^Користувачі$}
    expect(page.title).to eq "Користувачі | Admin"
    expect(page).to have_content "admin@test Admin User true -"
    expect(page).to have_content "user@lev - - false Старий Лев"
  end
end
