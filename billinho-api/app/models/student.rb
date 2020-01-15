# Validates the student params for the database
class Student < ApplicationRecord
  validates :nome, presence: true, uniqueness: true
  validates :cpf, numericality: { only_integer: true }, length: { is: 11 }, uniqueness: true, presence: true
  validates :telefone, numericality: { only_integer: true }
  validates :genero, presence: true, inclusion: { in: %w(M F), message: "%{value} deve estar entre M ou F" }
  validates :pagamento, presence: true, inclusion: { in: %w(Boleto Cartao), message: "%{value} deve estar entre Boleto ou Cartao" }
  has_one :registrations
end
