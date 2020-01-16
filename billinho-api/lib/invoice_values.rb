# Automatic creation of invoice values given the amount and number of invoices
class InvoiceValues
  attr_reader :invoice_value, :remainder, :last_invoice_value

  def initialize(amount, number_of_invoices)
    create_invoice_values(amount, number_of_invoices)
  end

  # invoice_value is the standard value of created invoices
  # above two decimal places the value is truncated and remainder contains the difference
  # last_invoice contains a fixed value for match the amount
  def create_invoice_values(amount, number_of_invoices)
    @invoice_value = (amount / number_of_invoices).truncate(2)

    @remainder = amount - (@invoice_value * number_of_invoices)

    @last_invoice_value = @invoice_value + @remainder.round(2, half: :up)
  end
end
