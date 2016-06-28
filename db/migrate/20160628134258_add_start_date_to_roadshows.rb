class AddStartDateToRoadshows < ActiveRecord::Migration[5.0]
  def change
    add_column :roadshows, :start_date, :datetime
  end
end
