# Create first due date and iterate the next due dates
module InvoiceDate
  # Returns the date with placed due_day if is a valid date, or last day of the month if isn't
  # If due_day is past the current date, the due date will be set for the next month
  def self.invoice_first_date(due_day)
    due_date = due_day <= Time.zone.today.day ? Time.zone.today.next_month : Time.zone.today
    return Date.new(due_date.year, due_date.month, due_day) if Date.valid_date?(due_date.year, due_date.month, due_day)

    Date.civil(due_date.year, due_date.month, -1)
  end

  # Returns the due date for the next month
  # The next_month method places last day of the month if the due_day is not valid
  def self.invoice_date_iter(due_date, due_day)
    next_date = due_date.next_month
    return Date.new(next_date.year, next_date.month, due_day) if Date.valid_date?(next_date.year, next_date.month, due_day)

    next_date
  end
end
