class AddIsPaidToRoadshows < ActiveRecord::Migration[5.0]
  def change
    add_column :roadshows, :is_paid, :boolean
  end
end
