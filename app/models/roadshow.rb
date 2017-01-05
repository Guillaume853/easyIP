class Roadshow < ApplicationRecord
  has_attachment :presentation
  has_many :accesss
  has_many :latestpages
  has_many :invoices


  belongs_to :user
  validates :company, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
