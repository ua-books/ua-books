module RSpec
  module FeatureHelper
    def select_date(date, from:)
      input = find_field(from)
      input.set(date.to_s)
    end
  end
end
