class Latestpage < ApplicationRecord
  require 'csv'

  belongs_to :user
  belongs_to :roadshow



  def self.to_csv(options = {})
    desired_columns = ["id"]
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |latestpage|
        csv << latestpage.attributes.values_at(*desired_columns)
      end
    end
  end


end
