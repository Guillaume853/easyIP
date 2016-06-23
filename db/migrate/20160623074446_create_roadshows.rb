class CreateRoadshows < ActiveRecord::Migration[5.0]
  def change
    create_table :roadshows do |t|
      t.string :company
      t.string :url

      t.timestamps
    end
  end
end
