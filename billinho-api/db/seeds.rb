# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
50.times do
  Institution.create(
    nome: Faker::University.unique.name,
    cnpj: Faker::Company.unique.brazilian_company_number,
    tipo: ["Universidade", "Escola", "Creche"].sample,
  )
end

200.times do
  Student.create(
    nome: Faker::Name.unique.name,
    cpf: Faker::IDNumber.unique.brazilian_citizen_number,
    dt_nasc: Faker::Date.birthday(min_age: 5, max_age: 100),
    telefone: Faker::PhoneNumber.cell_phone.delete(" ().-"),
    genero: ["M", "F"].sample,
    pagamento: ["Boleto", "Cartao"].sample,
  )
end

50.times do |i|
  registration = Registration.create(
    valor_total: Faker::Number.decimal(l_digits: 4, r_digits: 2),
    qd_faturas: rand(1..12),
    vencimento: rand(1..31),
    curso: Faker::Educator.subject,
    institution_id: rand(1..50),
    student_id: i+1,
  )

  InvoiceCreation.create(registration, registration.id)
end
