# Automatic creation of invoices given de reggistration params
class InvoiceCreation
  # Create values and dates of invoices and pass to create_new_invoice function
  # Return array of invoices
  def self.create(params, registration_id)
    invoices_array = []
    invoice_values = InvoiceValues.new(params[:valor_total], params[:qd_faturas])
    due_date = InvoiceDate.invoice_first_date(params[:vencimento])

    (params[:qd_faturas] - 1).times do
      invoices_array << create_new_invoice(invoice_values.invoice_value, due_date, registration_id)
      due_date = InvoiceDate.invoice_date_iter(due_date, params[:vencimento])
    end

    invoices_array << create_new_invoice(invoice_values.last_invoice_value, due_date, registration_id)
    invoices_array
  end

  def self.create_new_invoice(invoice_value, due_date, registration_id)
    invoice_params = {
      'valor' => invoice_value,
      'dt_vencimento' => due_date,
      'registration_id' => registration_id,
    }
    invoice = Invoice.new(invoice_params)
    if invoice.save
      { status: '200', message: "Invoice saved with id #{invoice.id}", data: invoice }
    else
      { status: '422', error: 'Invoice not saved', data: invoice.errors }
    end
  end
end
