class RemoveStartDatePublicFromRoadshow < ActiveRecord::Migration[5.0]
  def change
    remove_column :roadshows, :start_date_public, :boolean
  end
end
