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
         .round(2)
  rescue NoMethodError
    '?'
  end

  def vote_analysis
    total = cards.count
    cards.group(:point).order(point: :desc).count.to_a
         .map { { point: _1, count: _2, percentage: percentage(_2, total) } }
         .map { OpenStruct.new(_1) }
  end

  private

  def percentage(count, total)
    ActiveSupport::NumberHelper.number_to_percentage(
      count.to_f / total * 100, precision: 0
    )
  end

  def generate_base
    loop do
      self.base = SecureRandom.base58
      break unless Room.where(base: base).exists?
    end
  end
end
