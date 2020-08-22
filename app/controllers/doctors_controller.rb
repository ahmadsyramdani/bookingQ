class DoctorsController < ApiController
  def index
    @doctors = Doctor.includes(:specialist).page(params[:page])
    render file: 'doctors/index', status: :ok
  end

  def show
    @doctor = Doctor.includes(:specialist).find_by(id: params[:id])
    if @doctor
      render file: 'doctors/show', status: :ok
    else
      render file: 'utils/not_found', status: :not_found
    end
  end
end
