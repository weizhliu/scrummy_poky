class User < ApplicationRecord
  has_many :cards
  has_many :rooms

  before_create :generate_uuid

  after_update_commit -> { broadcast_replace_later_to [self, 'name_tag'], partial: 'users/name_tag' }

  def generate_uuid
    loop do
      self.uuid = SecureRandom.uuid
      break unless User.where(uuid: uuid).exists?
    end
  end
end
