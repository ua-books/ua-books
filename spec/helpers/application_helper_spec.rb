require 'rails_helper'

RSpec.describe ApplicationHelper do
  specify "#parameterize" do
    expect(helper.parameterize("Оксана Була «Зубр шукає гніздо»")).to eq "оксана-була-зубр-шукає-гніздо"
  end
end
