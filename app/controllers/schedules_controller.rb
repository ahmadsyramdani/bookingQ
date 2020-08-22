class SchedulesController < ApiController
  def index
    @doctor = Doctor.includes(schedules: [:hospital]).find_by(id: params[:id])
    return render file: 'utils/not_found', status: :not_found unless @doctor

    render file: 'doctors/schedules', status: :ok
  end

  def show
    @doctor = Doctor.find_by(id: params[:id])
    return render file: 'utils/not_found', status: :not_found unless @doctor

    @schedule = @doctor.schedules.find_by(id: params[:schedule_id])
    return render file: 'utils/not_found', status: :not_found unless @schedule

    @group_bookings = @schedule.bookings.upcoming.group_by(&:appointment_at)
    @bookings = Kaminari.paginate_array(@group_bookings, total_count: @group_bookings.count).page(params[:page]).per(5)
    render file: 'doctors/schedule', status: :ok
  end
end
