class AddMessageToRoadshows < ActiveRecord::Migration[5.0]
  def change
    add_column :roadshows, :message, :string
  end
end
