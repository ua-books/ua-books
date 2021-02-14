# A pen name.
# Example: Лариса Косач wrote her works under Леся Українка alias.
#
# If an author writes under her/his real name, s/he would have single
# alias with the same #first_name, #last_name.
class AuthorAlias < ApplicationRecord
  validates_presence_of :first_name, :last_name
  validates_uniqueness_of :first_name, scope: [:last_name, :author_id]

  belongs_to :author, inverse_of: :aliases

  has_many :works, inverse_of: :aliases
end
