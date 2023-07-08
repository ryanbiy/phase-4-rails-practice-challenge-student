class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index 
        instructors = Instructor.all 
        render json: instructors
    end

    def show 
        instructor = find_instuctor
        render json: instructor, include: [:students]
    end

    def create 
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end

    def update 
        instructor = find_instuctor
        instructor.update!(instructor_params)
        render json: instructor
    end

    def destroy 
        instructor = find_instuctor
        instructor.destroy
        render json: {success: "instructor was deleted successfully" }
    end


    private

    def find_instuctor
        Instructor.find(params[:id])
    end

    def instructor_params
        params.permit(:name)
    end

    def render_not_found_response
        render json: { error: "Instructor not found" }, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
      end
end
