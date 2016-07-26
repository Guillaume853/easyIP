class AddPagesToRoadshows < ActiveRecord::Migration[5.0]
  def change
    add_column :roadshows, :number_of_pages, :integer
  end
end
