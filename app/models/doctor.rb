class Doctor < ApplicationRecord
  has_many :schedules
  belongs_to :specialist

  paginates_per 10

  def specialist_name
    specialist.name
  end
end
