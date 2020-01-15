# Validates the invoice params for the database
# status attribute has default value
class Invoice < ApplicationRecord
  attribute :status, :string, default: "Aberta"
  validates :valor, presence: true
  validates :dt_vencimento, presence: true
  validates :status, presence: true, inclusion: { in: %w(Aberta Atrasada Paga), message: "%{value} deve estar entre Aberta, Atrasada ou Paga" }
  belongs_to :registration
end
