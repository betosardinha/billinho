module Api
  module V1
    # Controller class for Institution model
    class InstitutionsController < ApplicationController
      # List all institutions
      def index
        institutions = Institution.order('created_at DESC')
        return render json: { status: '404', error: 'No Institutions in database' }, status: :not_found if institutions.empty?

        render json: { status: '200', message: 'Loaded Institutions', data: institutions }, status: :ok
      end

      # List institution by id
      def show
        institution = Institution.find(params[:id])
        render json: { status: '200', message: "Loaded Institution with id #{params[:id]}", data: institution }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { status: '404', error: "No Institution with id #{params[:id]}", data: institution }, status: :not_found
      end

      # Create new institution
      def create
        institution = Institution.new(institution_params)
        if institution.save
          render json: { status: '200', message: "Institution saved with id #{institution.id}", data: institution }, status: :ok
        else
          render json: { status: '422', error: 'Institution not saved', data: institution.errors }, status: :unprocessable_entity
        end
      end

      # Delete institution
      def destroy
        institution = Institution.find(params[:id])
        institution.destroy
        render json: { status: '200', message: "Deleted Institution with id #{params[:id]}", data: institution }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { status: '404', error: "No Institution with id #{params[:id]}", data: institution }, status: :not_found
      end

      # Update institution by id
      # Handling errors from not finding the id and wrong data
      def update
        institution = Institution.find(params[:id])
        if institution.update(institution_params)
          render json: { status: '200', message: "Updated Institution with id #{params[:id]}", data: institution }, status: :ok
        else
          render json: { status: '422', error: 'Institution not updated', data: institution.errors }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { status: '404', error: "No Institution with id #{params[:id]}", data: institution }, status: :not_found
      end

      private

      def institution_params
        params.permit(:nome, :cnpj, :tipo)
      end
    end
  end
end
