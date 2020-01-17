module Api
  module V1
    # Controller class for Invoice model
    class InvoicesController < ApplicationController
      # List all invoices
      def index
        invoices = Invoice.order('created_at DESC')
        return render json: { status: '404', error: 'No Invoices in database' }, status: :not_found if invoices.empty?

        render json: { status: '200', message: 'Loaded Invoices', data: invoices }, status: :ok
      end

      # List invoice by id
      def show
        invoice = Invoice.find(params[:id])
        render json: { status: '200', message: "Loaded Invoice with id #{params[:id]}", data: invoice }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { status: '404', error: "No Invoice with id #{params[:id]}", data: invoice }, status: :not_found
      end

      # Create new invoice
      def create
        invoice = Invoice.new(invoice_params)
        if invoice.save
          render json: { status: '200', message: "Invoice saved with id #{invoice.id}", data: invoice }, status: :ok
        else
          render json: { status: '422', error: 'Invoice not saved', data: invoice.errors }, status: :unprocessable_entity
        end
      end

      # Delete invoice
      def destroy
        invoice = Invoice.find(params[:id])
        invoice.destroy
        render json: { status: '200', message: "Deleted Invoice with id #{params[:id]}", data: invoice }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { status: '404', error: "No Invoice with id #{params[:id]}", data: invoice }, status: :not_found
      end

      # Update invoice by id
      # Handling errors from not finding the id and wrong data
      def update
        invoice = Invoice.find(params[:id])
        if invoice.update(invoice_params)
          render json: { status: '200', message: "Updated Invoice with id #{params[:id]}", data: invoice }, status: :ok
        else
          render json: { status: '422', error: 'Invoice not updated', data: invoice.errors }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { status: '404', error: "No Invoice with id #{params[:id]}", data: invoice }, status: :not_found
      end

      private

      def invoice_params
        params.permit(:valor, :dt_vencimento, :status, :registration_id)
      end
    end
  end
end
