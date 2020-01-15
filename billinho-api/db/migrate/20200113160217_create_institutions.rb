class CreateInstitutions < ActiveRecord::Migration[6.0]
  def change
    create_table :institutions do |t|
      t.string :nome
      t.string :cnpj
      t.string :tipo

      t.timestamps
    end
  end
end
