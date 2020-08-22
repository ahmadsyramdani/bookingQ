class Hospital < ApplicationRecord
  has_many :schedules

  paginates_per 10
end
