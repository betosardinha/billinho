# Validates the institution params for the database
class Institution < ApplicationRecord
  validates :nome, presence: true, uniqueness: true
  validates :cnpj, numericality: { only_integer: true }, length: { is: 14 }, uniqueness: true, presence: true
  validates :tipo, presence: true, inclusion: { in: %w(Universidade Escola Creche), message: "%{value} deve estar entre Universidade, Escola ou Creche" }
  has_many :registrations
end
