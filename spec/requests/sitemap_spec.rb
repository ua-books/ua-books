require "rails_helper"

RSpec.describe "/sitemap.xml" do
  specify "visiting" do
    book = create(:book, updated_at: "2017-12-11")

    get "/sitemap.xml"

    xml = Capybara.string(response.body)
    url = xml.find(:xpath, "//urlset/url")
    expect(url).to have_selector("loc", text: "http://www.example.com/#{book.id}")
    expect(url).to have_selector("changefreq", text: "always")
    expect(url).to have_selector("lastmod", text: "2017-12-11T00:00:00")
  end
end
