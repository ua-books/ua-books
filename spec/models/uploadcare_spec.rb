require "rails_helper"

RSpec.describe Uploadcare do
  describe ".url" do
    specify "no image is substituted with a transparent pixel" do
      url = Uploadcare.url(nil)
      expect(url).to eq "https://ucarecdn.com/cddfded1-2508-4248-87ab-3aea6c3d71d0/"
    end

    specify "no operations" do
      url = Uploadcare.url("https://ucarecdn.com/:uuid/")
      expect(url).to eq "https://ucarecdn.com/:uuid/"
    end

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
