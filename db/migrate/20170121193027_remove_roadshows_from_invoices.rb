class RemoveRoadshowsFromInvoices < ActiveRecord::Migration[5.0]
  def change
    remove_reference :invoices, :roadshow, foreign_key: true
  end
end
