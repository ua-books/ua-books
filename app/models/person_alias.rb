# A pen name.
# Example: Лариса Косач wrote her works under Леся Українка alias.
#
# If a person writes under her/his real name, s/he would have single
# alias with the same #first_name, #last_name.
class PersonAlias < ApplicationRecord
  validates_presence_of :first_name, :last_name

  belongs_to :person, inverse_of: :aliases
end
