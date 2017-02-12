class AddTitleListToRoadshows < ActiveRecord::Migration[5.0]
  def change
    add_column :roadshows, :title_list, :string, array: true, default: []
  end
end
