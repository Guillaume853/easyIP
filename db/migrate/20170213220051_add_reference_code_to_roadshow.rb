class AddReferenceCodeToRoadshow < ActiveRecord::Migration[5.0]
  def change
    add_column :roadshows, :reference_code, :string
  end
end
