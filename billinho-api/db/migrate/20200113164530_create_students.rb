class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.string :nome
      t.string :cpf
      t.date :dt_nasc
      t.bigint :telefone
      t.string :genero
      t.string :pagamento

      t.timestamps
    end
  end
end
