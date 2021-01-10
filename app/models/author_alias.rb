# A pen name.
# Example: Лариса Косач wrote her works under Леся Українка alias.
#
# If an author writes under her/his real name, s/he would have single
# alias with the same #first_name, #last_name.
class AuthorAlias < ApplicationRecord
  validates_presence_of :first_name, :last_name

  belongs_to :author, foreign_key: "person_id", inverse_of: :aliases
end
