class CreateLatestpages < ActiveRecord::Migration[5.0]
  def change
    create_table :latestpages do |t|
      t.integer :page
      t.references :user, foreign_key: true
      t.references :roadshow, foreign_key: true

      t.timestamps
    end
  end
end
