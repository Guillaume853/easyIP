class AddUserToRoadshows < ActiveRecord::Migration[5.0]
  def change
    add_reference :roadshows, :user, foreign_key: true
  end
end
