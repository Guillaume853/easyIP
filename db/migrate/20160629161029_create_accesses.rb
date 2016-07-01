class CreateAccesses < ActiveRecord::Migration[5.0]
  def change
    create_table :accesses do |t|
      t.references :user, foreign_key: true
      t.references :roadshow, foreign_key: true
      t.datetime :start_access
      t.datetime :end_access

      t.timestamps
    end
  end
end
