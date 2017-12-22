class Question < ApplicationRecord
  validates :email, :name, :message, presence: true
end
