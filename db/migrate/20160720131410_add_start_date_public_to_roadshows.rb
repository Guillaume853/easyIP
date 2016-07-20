class AddStartDatePublicToRoadshows < ActiveRecord::Migration[5.0]
  def change
    add_column :roadshows, :start_date_public, :boolean
  end
end
