class CreateRegistrations < ActiveRecord::Migration[6.0]
  def change
    create_table :registrations do |t|
      t.decimal :valor_total
      t.integer :qd_faturas
      t.integer :vencimento
      t.string :curso
      t.references :institution, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
