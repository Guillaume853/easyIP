class AddEndDateToRoadshows < ActiveRecord::Migration[5.0]
  def change
    add_column :roadshows, :end_date, :datetime
  end
end
