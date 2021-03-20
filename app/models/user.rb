class User < ApplicationRecord
  has_many :cards
  has_many :rooms

  before_create :generate_uuid

  def generate_uuid
    loop do
      self.uuid = SecureRandom.uuid
      break unless User.where(uuid: uuid).exists?
    end
  end
end
