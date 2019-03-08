require "rails_helper"

RSpec.describe Uploadcare do
  describe ".url" do
    specify "one operation" do
      url = Uploadcare.url("https://ucarecdn.com/:uuid/", resize: "x100")
      expect(url).to eq "https://ucarecdn.com/:uuid/-/resize/x100/"
    end

    specify "two operations" do
      url = Uploadcare.url("https://ucarecdn.com/:uuid/", resize: "x100", format: "webp")
      expect(url).to eq "https://ucarecdn.com/:uuid/-/resize/x100/-/format/webp/"
    end
  end

  specify ".signature" do
    valid_to = Time.utc(2019, 3, 8, 17, 43, 30)
    expect(Uploadcare.signature(valid_to)).to eq "23aae6e66d5ff76899725747cc9f4712"
  end
end
