require "rails_helper"

RSpec.describe "authors#show" do
  specify "without seo name" do
    expect(get: "/a/3").to route_to(controller: "authors", action: "show", id: "3")
  end

  specify "with non-int ID" do
    expect(get: "/a/the-author").to_not be_routable
  end

  specify "with seo name" do
    expect(get: "/neil-gaiman/a/3").to route_to(controller: "authors", action: "show", slug: "neil-gaiman", id: "3")
  end
end
