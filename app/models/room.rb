class Room < ApplicationRecord
  belongs_to :user
  has_many :cards

  enum status: %i[open end], _default: :open

  before_create :generate_base
  after_update_commit -> { broadcast_replace_later_to [self, 'status'] }

  def average_point
    cards.where.not(point: '?')
         .pluck(:point)
         .then { _1.map(&:to_f).reduce(&:+) / _1.count }
  rescue NoMethodError
    '?'
  end

  private

  def generate_base
    loop do
      self.base = SecureRandom.base58
      break unless Room.where(base: base).exists?
    end
  end
end
