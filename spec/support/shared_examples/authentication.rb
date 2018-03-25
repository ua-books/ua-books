RSpec.shared_examples "authentication" do
  it "requires authentication" do
    visit page_url
    expect(page.title).to eq "Вхід | Admin"
    expect(page).to have_content "Будь ласка, скористайтеся входом через соцмережі, щоб ідентифікувати себе."
  end
end
