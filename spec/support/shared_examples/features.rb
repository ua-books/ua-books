RSpec.shared_examples "features" do
  it "requires authentication" do
    visit page_url
    expect(page.title).to eq "Вхід | Admin"
    expect(page).to have_content "Будь ласка, скористайтеся входом через соцмережі, щоб ідентифікувати себе."
  end

  it "allows to sign out" do
    visit page_url
    sign_in_as create(:user, email: "mail@mail.com")
    expect(page).to have_content "mail@mail.com"
    click_on "Вийти"
    expect(page).to have_no_content "mail@mail.com"
    expect(page.title).to eq "Вхід | Admin"
    expect(page).to have_content "Будь ласка, скористайтеся входом через соцмережі, щоб ідентифікувати себе."
  end

  it "handles denied permission" do
    visit page_url
    sign_in_as create(:user)
    expect(current_url).to eq new_admin_publisher_url
    expect(page).to have_content "Ви ідентифіковані, але наразі не керуєте жодним видавництвом"
  end
end
