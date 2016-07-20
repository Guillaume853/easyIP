class RemoveEndDatePublicFromRoadshow < ActiveRecord::Migration[5.0]
  def change
    remove_column :roadshows, :end_date_public, :boolean
  end
end
