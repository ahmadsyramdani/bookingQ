class BookingsController < ApiController
  def index
    @bookings = current_user.bookings.includes(:user, schedule: %i[hospital doctor]).page(params[:page]).order('appointment_at ASC')
    render file: 'bookings/index', status: :ok
  end

  def show
    @booking = current_user.bookings.find_by(id: params[:id])
    if @booking
      render file: 'bookings/show', status: :ok
    else
      render file: 'utils/not_found', status: :not_found
    end
  end

  def create
    @booking = current_user.bookings.new(schedule_params)
    if @booking.save
      render file: 'bookings/show', status: :ok
    else
      @error = @booking.errors.full_messages.uniq.join(', ')
      render file: 'utils/failed', status: :unprocessable_entity
    end
  end

  private

  def schedule_params
    params.required(:schedule).permit(:schedule_id, :appointment_at)
  end
end
