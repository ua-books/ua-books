require "rails_helper"

RSpec.describe "Seeds" do
  it "works" do
    file = Rails.root.join("db/seeds.rb")
    eval File.read(file), TOPLEVEL_BINDING, file.to_s
  end
end
