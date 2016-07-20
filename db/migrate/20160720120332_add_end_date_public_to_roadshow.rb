class AddEndDatePublicToRoadshow < ActiveRecord::Migration[5.0]
  def change
    add_column :roadshows, :end_date_public, :boolean
  end
end
