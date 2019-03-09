require "rails_helper"

RSpec.describe "/sitemap.xml" do
  specify "published book" do
    book = create(:book, :published, title: "Зубр шукає гніздо", updated_at: "2017-12-11")

    get "/sitemap.xml"

    xml = Capybara.string(response.body)
    xml.native.remove_namespaces!
    expect(xml).to have_selector(:xpath, "//urlset/url")
    url = xml.find(:xpath, "//urlset/url")
    expect(url).to have_selector("loc", text: "http://www.example.com/#{book.id}")
    expect(url).to have_selector("changefreq", text: "always")
    expect(url).to have_selector("lastmod", text: "2017-12-11T00:00:00")
    expect(url).to have_selector("image")
    image = url.find("image")
    expect(image).to have_selector("loc", text: book.cover_url)
    expect(image).to have_selector("title", text: "Обкладинка до книги «Зубр шукає гніздо»")
  end

  specify "draft book" do
    create(:book)

    get "/sitemap.xml"

    xml = Capybara.string(response.body)
    xml.native.remove_namespaces!
    expect(xml).to_not have_selector(:xpath, "//urlset/url")
  end
end
