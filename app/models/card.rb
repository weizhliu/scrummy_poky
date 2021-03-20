class Card < ApplicationRecord
  belongs_to :user
  belongs_to :room

  enum status: %i[fold reveal], _default: :fold
  POINTS = %w[0 1 2 3 5 8 13 21 34 55 89 ?].freeze
end
