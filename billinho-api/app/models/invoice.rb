# Validates the invoice params for the database
# status attribute has default value
class Invoice < ApplicationRecord
  attribute :status, :string, default: "Aberta"
  validates :valor, presence: true, numericality: true
  validates :dt_vencimento, presence: true, date: true
  validates :status, presence: true, inclusion: { in: %w(Aberta Atrasada Paga), message: "%{value} deve estar entre Aberta, Atrasada ou Paga" }
  validates :registration_id, numericality: { only_integer: true }, presence: true
  belongs_to :registration
end
