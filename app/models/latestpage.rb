class Latestpage < ApplicationRecord
  require 'csv'

  belongs_to :user
  belongs_to :roadshow



  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes
      end
    end
  end


end
