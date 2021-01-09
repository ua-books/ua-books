require "rails_helper"

RSpec.describe "publishers#show" do
  specify "without seo name" do
    expect(get: "/p/3").to route_to(controller: "publishers", action: "show", id: "3")
  end

  specify "with non-int ID" do
    expect(get: "/p/the-publisher").to_not be_routable
  end

  specify "with seo name" do
    expect(get: "/tempora/p/3").to route_to(controller: "publishers", action: "show", slug: "tempora", id: "3")
  end
end
