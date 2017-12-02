class Coefficent < ApplicationRecord
  belongs_to :currency

  before_save :set_timestamps

  validates :currency, presence: true
  validate :only_one_coefficent_for_currency_present

  scope :active, -> () { where('timestamp_from < ? and timestamp_to > ?', Time.zone.now, Time.zone.now) }

  def only_one_coefficent_for_currency_present
    self.currency.coefficents.count == 1
  end

  def set_timestamps
    self.timestamp_from ||= Date.today.to_time
    self.timestamp_to   ||= self.timestamp_from + 1.day
  end

end
