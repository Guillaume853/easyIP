class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.float :price
      t.boolean :is_paid
      t.references :roadshow, foreign_key: true

      t.timestamps
    end
  end
end
