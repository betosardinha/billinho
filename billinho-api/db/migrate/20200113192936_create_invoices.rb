class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.decimal :valor
      t.date :dt_vencimento
      t.references :registration, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
