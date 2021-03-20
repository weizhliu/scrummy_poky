class Room < ApplicationRecord
  has_many :cards

  before_create generate_base

  enum status: %i[open lock], _default: :open

  def generate_base
    loop do
      self.uuid = SecureRandom.base58
      break unless Room.where(base: base).exists?
    end
  end
end
