require "rails_helper"

RSpec.describe "Person" do
  specify "automatic alias after create" do
    person = create(:person, first_name: "Юрій", last_name: "Шевельов")
    main_alias = person.main_alias
    expect(main_alias).to be
    expect(main_alias.first_name).to eq "Юрій"
    expect(main_alias.last_name).to eq "Шевельов"
  end
end
