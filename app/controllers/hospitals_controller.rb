class HospitalsController < ApiController
  def index
    @hospitals = Hospital.page(params[:page])
    render file: 'hospitals/index', status: :ok
  end

  def show
    @hospital = Hospital.find_by(id: params[:id])
    if @hospital
      render file: 'hospitals/show', status: :ok
    else
      render file: 'utils/not_found', status: :not_found
    end
  end
end
