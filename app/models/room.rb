class Room < ApplicationRecord
  belongs_to :user
  has_many :cards

  before_create :generate_base

  enum status: %i[open end], _default: :open
  after_update_commit -> { broadcast_replace_later_to [self, 'status'] }

  def generate_base
    loop do
      self.base = SecureRandom.base58
      break unless Room.where(base: base).exists?
    end
  end
end
