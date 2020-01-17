module Api
  module V1
    # Controller class for Institution model
    class StudentsController < ApplicationController
      # List all students
      def index
        students = Student.order('created_at DESC')
        return render json: { status: '404', error: 'No Students in database' }, status: :not_found if students.empty?

        render json: { status: '200', message: 'Loaded Students', data: students }, status: :ok
      end

      # List student by id
      def show
        student = Student.find(params[:id])
        render json: { status: '200', message: "Loaded Student with id #{params[:id]}", data: student }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { status: '404', error: "No Student with id #{params[:id]}", data: student }, status: :not_found
      end

      # Create new student
      def create
        student = Student.new(student_params)
        if student.save
          render json: { status: '200', message: "Student saved with id #{student.id}", data: student }, status: :ok
        else
          render json: { status: '422', error: 'Student not saved', data: student.errors }, status: :unprocessable_entity
        end
      end

      # Delete student
      def destroy
        student = Student.find(params[:id])
        student.destroy
        render json: { status: '200', message: "Deleted Student with id #{params[:id]}", data: student }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { status: '404', error: "No Student with id #{params[:id]}", data: student }, status: :not_found
      end

      # Update student by id
      # Handling errors from not finding the id and wrong data
      def update
        student = Student.find(params[:id])
        if student.update(student_params)
          render json: { status: '200', message: "Updated Student with id #{params[:id]}", data: student }, status: :ok
        else
          render json: { status: '422', error: 'Student not updated', data: student.errors }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { status: '404', error: "No Student with id #{params[:id]}", data: student }, status: :not_found
      end

      private

      def student_params
        params.permit(:nome, :cpf, :dt_nasc, :telefone, :genero, :pagamento)
      end
    end
  end
end
