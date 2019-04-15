class Project < ApplicationRecord
  validates :name, presence: true, length: {minimum: 5}
  validates :summary, presence: true, length: {minimum: 20}

  # Ressource : https://github.com/adzap/validates_timeliness
  validates_date :end_date, after: :start_date
end
