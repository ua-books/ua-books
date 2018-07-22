RSpec.shared_examples "features" do
  it "requires authentication" do
    visit page_url
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
