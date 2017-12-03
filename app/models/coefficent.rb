class Coefficent < ApplicationRecord
  belongs_to :currency

  before_create :set_timestamp_from
  before_create :set_timestamp_to
  before_create :expiry_previous_coefficent

  def rivals
    self.currency.active_coefficents
  end

  validates :currency, presence: true
  validate :only_one_coefficent_for_currency_present

  scope :active, -> () { where('timestamp_from < ? and timestamp_to is null', Time.zone.now) }

  def only_one_coefficent_for_currency_present
    rivals.count == 1
  end

  def set_timestamp_from
    self.timestamp_from ||= Date.today.to_time
    rivals.each do |coefficent|
      self.timestamp_from = [coefficent.timestamp_to, self.timestamp_from].max if coefficent.timestamp_to && coefficent.id != self.id
    end
  end

  def expiry_previous_coefficent
    rivals_list = rivals()
    rivals_list.find_each do |coefficent|
      coefficent.expiry if coefficent.id != self.id
    end
  end


  def expiry
    self.update(timestamp_to: Time.zone.now)
  end

  def set_timestamp_to
    self.timestamp_to = nil
  end

end
