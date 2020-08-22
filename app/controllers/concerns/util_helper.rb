module UtilHelper
  def pretty_hour(hour)
    date = Time.current.beginning_of_day + hour.hour
    date.strftime('%H:%M')
  end
end
