# Validates the registration params for the database
class Registration < ApplicationRecord
  validates :valor_total, numericality: { greater_than: 0 }, presence: true
  validates :qd_faturas, numericality: { only_integer: true, greater_than_or_equal_to: 1 }, presence: true
  validates :vencimento, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 31 }, presence: true
  validates :curso, presence: true
  belongs_to :institution
  belongs_to :student
  has_many :invoices
end
