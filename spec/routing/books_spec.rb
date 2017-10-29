require "rails_helper"

RSpec.describe "books#show" do
  specify "without seo name" do
    expect(get: "/3").to route_to(controller: "books", action: "show", id: "3")
  end

  specify "with seo name" do
    expect(get: "/oksana-bula-zubr-shukaie-hnizdo/3").to route_to(controller: "books", action: "show", slug: "oksana-bula-zubr-shukaie-hnizdo", id: "3")
  end
end
