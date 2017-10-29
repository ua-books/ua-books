# Links persons (via aliases) with books.
# A person can easily be a text author for a certain book
# and at the same time to be a translator for another one. It's not
# unusual to even mix roles within one book (for example, to be
# a text author and an illustrator).
class Work < ApplicationRecord
  belongs_to :book, inverse_of: :works
  belongs_to :type, class_name: "WorkType", foreign_key: "work_type_id"
  belongs_to :person_alias

  delegate :person, to: :person_alias

  def self.for_list
    preload(:type, person_alias: :person)
  end
end
