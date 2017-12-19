# A real person.
# Example: Сергій Жадан.
#
# A person is linked to her/his works via aliases (pen names).
class Person < ApplicationRecord
  validates_presence_of :first_name, :last_name, :gender
  validates_inclusion_of :gender, in: %w[female male]

  has_many :aliases, class_name: "PersonAlias", inverse_of: :person

  after_create do
    aliases.create!(first_name: first_name, last_name: last_name)
  end

  def main_alias
    aliases.first
  end
end
