module Api
  module V1
    # Controller class for Invoice model
    class RegistrationsController < ApplicationController
      # List all invoices
      def index
        registrations = Registration.order('created_at DESC')
        return render json: { status: '404', error: 'No Registrations in database' }, status: :not_found if registrations.empty?

        render json: { status: '200', message: 'Loaded Registrations', data: registrations }, status: :ok
      end

      # List registration by id
      def show
        registration = Registration.find(params[:id])
        invoices = Invoice.where(registration_id: params[:id])
        render json: { status: '200', message: "Loaded Registration with id #{params[:id]}", data: registration, invoices: invoices }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { status: '404', error: "No Registration with id #{params[:id]}", data: registration }, status: :not_found
      end

      # Create new registration
      def create
        registration = Registration.new(registration_params)
        if registration.save
          invoices = InvoiceCreation.create(registration_params, registration.id)
          render json: { status: '200', message: "Registration saved with id #{registration.id}", data: registration, invoices: invoices }, status: :ok
        else
          render json: { status: '422', error: 'Registration not saved', data: registration.errors }, status: :unprocessable_entity
        end
      end

      # Delete registration
      def destroy
        registration = Registration.find(params[:id])
        registration.destroy
        render json: { status: '200', message: "Deleted Registration with id #{params[:id]}", data: registration }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { status: '404', error: "No Registration with id #{params[:id]}", data: registration }, status: :not_found
      end

      # Update invoice by id
      # Handling errors from not finding the id and wrong data
      def update
        registration = Registration.find(params[:id])
        if registration.update(registration_params)
          render json: { status: '200', message: "Updated Registration with id #{params[:id]}", data: registration }, status: :ok
        else
          render json: { status: '422', error: 'Registration not updated', data: registration.errors }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { status: '404', error: "No Registration with id #{params[:id]}", data: registration }, status: :not_found
      end

      private

      def registration_params
        params.permit(:valor_total, :qd_faturas, :vencimento, :curso, :institution_id, :student_id)
      end
    end
  end
end
