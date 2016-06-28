class Roadshow < ApplicationRecord
  validates :company, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
