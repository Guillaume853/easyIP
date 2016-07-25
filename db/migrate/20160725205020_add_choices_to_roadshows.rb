class AddChoicesToRoadshows < ActiveRecord::Migration[5.0]
  def change
    add_column :roadshows, :save, :boolean
    add_column :roadshows, :print, :boolean
    add_column :roadshows, :watermark, :boolean
  end
end
