class Card < ApplicationRecord
  belongs_to :user
  belongs_to :room

  enum status: %i[fold reveal], _default: :fold
end
